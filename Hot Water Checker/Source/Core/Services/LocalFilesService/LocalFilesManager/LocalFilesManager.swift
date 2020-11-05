import Foundation
import Zip


final class LocalFilesManager {
    
    // MARK: - Properties
    public static let shared: LocalFilesManager = LocalFilesManager()
    private let localFilesManager: FileManager
    private var localFilesDirectory: URL {
        let directoryURLsArray = self.localFilesManager.urls(for: .documentDirectory,
                                                            in: .userDomainMask)
        let filesDirectory = directoryURLsArray.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
        return filesDirectory
    }
    
    // MARK: - Initialization
    init() {
        self.localFilesManager = FileManager.default
    }
}


// MARK: - Methods
extension LocalFilesManager {
    
    ///Checking if archive needs to be saved and saving if so
    func saveArchiveIfNeeded(fromBase64EncodedString encodedString: String,
                             withName archiveName: String,
                             completion: @escaping (ArchiveResult) -> Void) {
        
        let archiveURL = self.createArchiveURL(withName: archiveName)
        
        guard self.isArchiveUpdateNeeded(atURL: archiveURL,
                                         newArchiveBase64Encoded: encodedString) else {
            completion(.success)
            return
        }
        
        self.decodeAndSaveArchive(fromBase64EncodedString: encodedString,
                                  withName: archiveName) { (result) in
            switch result {
            case .success:
                self.unzipArchive(archiveURL: archiveURL) { (result) in
                    
                    switch result {
                    case .success:
                        completion(.success)
                    case .failure(let unzippingError):
                        completion(.failure(unzippingError))
                    }
                }
            case .failure(let errorWhenSaving):
                completion(.failure(errorWhenSaving))
            }
        }
    }
    
    ///Attempt to read locally stored file
    func readLocalFile<T: Decodable>(withURL url: URL,
                                    ofType type: T.Type) -> T? {
        
        guard self.isFileExists(withURL: url) else {
            assertionFailure("There are no file at: \(url).")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("Can not get data from file at: \(url).")
            return nil
        }
        
        guard let objects = try? JSONDecoder().decode(T.self, from: data) else {
            assertionFailure("Cannot convert \(data) to \(String(describing: T.self))")
            return nil
        }
        
        return objects
    }
    
    // MARK: - Private methods
    
    ///Decoding and saving archive with specific name
    private func decodeAndSaveArchive(fromBase64EncodedString encodedString: String,
                                      withName archiveName: String,
                                      completion: @escaping (ArchiveResult) -> Void) {
        
        guard let zipFromData = decodeArchive(fromBase64EncodedString: encodedString) else {
            let error = ArchivationErrors.canNotDecode
            completion(.failure(error))
            return
        }
        
        let archiveURL = self.createArchiveURL(withName: archiveName)
        
        do {
            try zipFromData.write(to: archiveURL)
            completion(.success)
        } catch {
            print("Can not save Data to: \(archiveURL)")
            let error = ArchivationErrors.canNotSaveFile(error)
            completion(.failure(error))
        }
    }
}


// MARK: - Helper Methods

extension LocalFilesManager {
    
    ///Creating Archive URL
    func createArchiveURL(withName archiveName: String) -> URL {
        var filesDirectory = self.localFilesDirectory
        filesDirectory.appendPathComponent(archiveName)
        filesDirectory.appendPathExtension("zip")
        return filesDirectory
    }
    
    ///Creating Unzipped file URL
    func createPreviouslyUnzippedFileURL<T: PreviouslyUnzipped>(ofType fileType: T.Type) -> URL {
        var filesDirectory = self.localFilesDirectory
        let previouslyUnzippedFileName = fileType.previouslyUnzippedFileName
        filesDirectory.appendPathComponent(previouslyUnzippedFileName)
        filesDirectory.appendPathExtension("json")
        return filesDirectory
    }
    
    ///Decoding archive from base64 encoded String
    private func decodeArchive(fromBase64EncodedString encodedString: String) -> Data? {
        guard let zipFromData = Data(base64Encoded: encodedString) else {
            let error = ArchivationErrors.canNotDecode
            assertionFailure(error.localizedDescription)
            return nil
        }
        
        return zipFromData
    }
    
    ///Checks if file exists at specific URL
    func isFileExists(withURL url: URL) -> Bool {
        let path = url.path
        return self.localFilesManager.fileExists(atPath: path)
    }
    
    /// Unzipping Archive
    private func unzipArchive(archiveURL: URL,
                              completion: @escaping (ArchiveResult) -> ()) {
        let documentsDirectory = self.localFilesDirectory
        
        do {
            try Zip.unzipFile(archiveURL,
                              destination: documentsDirectory,
                              overwrite: false,
                              password: nil)
            completion(.success)
        } catch {
            let error = ArchivationErrors.canNotUnzipFile(error)
            completion(.failure(error))
        }
    }
    
    /// Checks if archive with such name already exists, if so, decodes new archive and compares to old one.
    private func isArchiveUpdateNeeded(atURL url: URL,
                                       newArchiveBase64Encoded: String) -> Bool {
        let path = url.path
        
        if self.isFileExists(withURL: url) {
            guard let existingArchiveData = self.localFilesManager.contents(atPath: path),
                  let newArchiveData = decodeArchive(fromBase64EncodedString: newArchiveBase64Encoded) else {
                return true
            }
            
            if existingArchiveData == newArchiveData {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
}
