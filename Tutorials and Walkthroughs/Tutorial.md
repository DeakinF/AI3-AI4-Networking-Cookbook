

# An Overview of the Exploits used and information Users’ should know before attempting the challenge

## CGI Exploits:
CGI or Common Gateway Interface, are scripts that enable web servers to execute external programs, often in lounges like perl or python, to produce dynamic content. Sometimes, mainly due to human error, poorly secured CGI scripts become vulnerable to exploits, such as command injection, or remote code execution. Through this, hackers are able to manipulate URLs or input fields, to inject malicious code that the server executes, giving unauthorised access or control over the system (in root). CGI vulnerabilities are most common when failing to sanitize user input or the allowance of shell access. 

## Decoding and Encrypting 
Decoding and encrypting are processes which are fundamental in data transmission and cyber security. Encryption transforms plaintext into an unreadable format, known as ciphertext. This protects information or data from unauthorized access. Decoding or decrypting this information is the process of reversing encoded information. One of the most common types of encryption is called base64 encryption. These two processes are integral to securing web-servers, communication systems and any online process that requires a transfer of secured data.

## HTTP headers and Exploits
HTTP headers are key-value pairs, sent in HTTP requests and responses, which often convey important information and metadata between a browser and a server. Request headers, include information such as the browser type, acceptable response formats and credentials. Response headers can contain data like content type, server details and caching rules. Headers can be security related, using script-transport-security or other processes to protect against cross site scripting attacks. Sometimes, important information can be left in headers often by mistake or lack of understanding, which can leave servers vulnerable to attacks. 

## Public and Private key encryption
Public and private key encryption, also known as asymmetric encryption, uses two mathematically linked keys. The public key is openly shared and used to encrypt data, whilst the private key is kept hidden and used to decrypt public keys. This ensures that only the intended recipient who holds the private key, can read the message. It is the backbone of secure communication protocols such as HTTPS, email encryption and digital signatures. Unlike symmetric encryption, which shares one key, asymmetric encryption improves security by removing the need to exchange private keys of potentially unsafe networks. If something is encrypted in a private key, the information is vulnerable, as anyone is able to encrypt the data with the available public key.

## Guidance for solving / Walkthrough: https://www.youtube.com/watch?v=IDs0xbK1N4k


