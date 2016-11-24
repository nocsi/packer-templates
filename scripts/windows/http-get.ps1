$client = new-object System.Net.WebClient
$client.DownloadFile("http://192.168.110.120:8000/dummy-request", "C:/dummy-request")
