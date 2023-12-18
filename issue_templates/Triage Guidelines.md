## Triage Guidelines

<details>
<summary><b> poetry failures </b></summary>

- Problem
 Ubuntu 20.04 LTS seems to have a problem with the poetry uses. The keyring is not willing to authenticate unless I set the keyring backend to null.


- Slotion 

```bash
export PYTHON_KEYRING_BACKEND=keyring.backends.fail.Keyringng
```