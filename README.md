# RC4 Decryption
Given a message encrypted using the RC4 algorithm and the secret key that was used, this circuit decrypts the message
using 3 finite state machines and datapaths. Here is a schematic of the top-level module:

<img src="https://i.imgur.com/W3b7LlD.png" width=500>

## Task 1
The first step is to initialize the working memory, `s`, with ascending values:
```
for i = 0 to 255
  s[i] = i
```
Here are the contents of `s` after initialization:

<img src="https://i.imgur.com/AwVrzy0.png" width=500>

And the schematic for the `task1` module:

<img src="https://i.imgur.com/CN8k3DT.png" width=500>
