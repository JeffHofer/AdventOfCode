class FileReader {
    fun readResource(path: String):  List<String>{
        return javaClass.getResource(path).readText().split('\n')
    }
}