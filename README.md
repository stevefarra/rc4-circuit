# RC4 Decryption
Given a message encrypted using the RC4 algorithm and the secret key that was used, this circuit decrypts the message
using a series of finite state machines and datapaths that interact with memories.

## Task 1
The first step is to initialize the working memory, `s`, with ascending values:
```
for i = 0 to 255
  s[i] = i
```
