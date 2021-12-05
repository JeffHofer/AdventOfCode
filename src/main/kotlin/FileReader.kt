open class FileReader {
    companion object {
        fun readResource(path: String, delimiter: String = "\n"):  List<String>{
            return javaClass.getResource(path).readText().split(delimiter)
        }
    }
}