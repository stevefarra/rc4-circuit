# RC4 Decryption
Given a message encrypted using the RC4 algorithm and the secret key that was used, this circuit decrypts the message
using 3 finite state machines and datapaths. Here is a schematic of the top-level module:

<img src="https://i.imgur.com/W3b7LlD.png" width=500>

## Task 1
The working memory, `s`, is initialized:
```
for i = 0 to 255
  s[i] = i
```
Here are the contents of `s` after initialization:

<img src="https://i.imgur.com/AwVrzy0.png" width=500>

And the schematic for the `task1` module:

<img src="https://i.imgur.com/CN8k3DT.png" width=500>

## Task 2
`s` is shuffled based on the secret key (in this example, `0x000249`):
```
j = 0
for i = 0 to 255
  j = (j + s[i] + secret_key[i mod keylength]) mod 256 // keylength is 3 in this implementation.
  swap values of s[i] and s[j]
```
Note that since the wordlength is 1 byte in memory, the mod 256 operation is already taken care of.

Here are the contents of `s` after the shuffle: 

<img src="https://i.imgur.com/C2sOKtX.png" width=750>
