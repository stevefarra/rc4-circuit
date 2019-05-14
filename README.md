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
Here are the contents of `s` after initialization and the schematic for the `task1` module:

<img src="https://i.imgur.com/AwVrzy0.png" width=400> <img src="https://i.imgur.com/CN8k3DT.png" width=400>

## Task 2
`s` is shuffled based on the secret key (in this example, `0x000249`):
```
j = 0
for i = 0 to 255
  j = (j + s[i] + secret_key[i mod keylength]) mod 256 // keylength = 3 in this implementation
  swap values of s[i] and s[j]
```
Note that the `mod 256` operation is already taken care of since the wordlength is 1 byte in memory. 

Here are the contents of `s` after the shuffle: 

<img src="https://i.imgur.com/C2sOKtX.png" width=800>

As well as the FSM and datapath schematic for the `task2a` module:

<img src="https://i.imgur.com/WoVsFjV.png" width=350> <img src="https://i.imgur.com/1EANi7H.png" width=500> 

## Task 3
Each character in the decrypted message is computed byte by byte:
```
i, j = 0
for k = 0 to (message_length - 1) // message_length = 32 in this implementation
  i++
  j += s[i]
  swap values of s[i] and s[j]
  f = s[s[i]+s[j]]
  decrypted_output[k] = f XOR encrypted_input[k] // 8-bit XOR function
```
Here are the contents of `dec_memory` after computation given the message in `enc_memory`:

<img src="https://i.imgur.com/7SOMOfd.png" width=800>

As well as the FSM and datapath for the `task2b` module:

<img src="https://i.imgur.com/18MJptG.png" width=275> <img src="https://i.imgur.com/ruLuZRm.png" width=500>

At the top-level view of the module, the FSM and datapath are connected in the following manner:

<img src="https://i.imgur.com/VaRyaAA.png" width=500>
