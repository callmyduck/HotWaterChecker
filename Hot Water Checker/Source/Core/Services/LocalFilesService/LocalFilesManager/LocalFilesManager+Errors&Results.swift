extension LocalFilesManager {
    
    enum ArchivationErrors: Error {
        case canNotUnzipFile(Error)
        case canNotReadFile
        case canNotSaveFile(Error)
        case canNotDecode
    }
    
    enum ArchiveResult {
        case success
        case failure(Error)
    }
}



