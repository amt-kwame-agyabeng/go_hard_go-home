# Dynamically grab my IP
data "http" "myip" {
    url = "http://api.ipify.org"
}