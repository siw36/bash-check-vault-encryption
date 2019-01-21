# Check vault encryption
This script checks if every file matching the configured naming pattern is encrypted and gives you helpful output before pushing to a git repository.  

## Configuration
__Naming convention filters:__  
Edit the `check_vault.sh` file and add/remove naming patterns to/from the `TYPES` array.  
All array entries will be used to find files matching these pattern.  
Found files will be checked for `ansible-vault` header.

## Usage
__Manual invocation:__  
Navigate to the git repository you want to push and exec the script.  

__Automated invocation:__  
Suitable if you want to perform this check every time you want to push new code to a git repository.  
Set an alias in your `.bashrc` to call this script.  
```bash
alias safepush='<path to the script>check_vault.sh'
```
*Note: you can't set a "two word" alias.*  
All arguments passed to the script are taken and used for the actual `git push` command.  
Emaples:  
```bash
# No arguments
safepush

# Origin and branch name
safepush origin master
```
Sample output:  
![Image](https://github.com/siw36/bash-check-vault-encryption/blob/master/images/sample_output.png)

## Current matching pattern
- `*vault*`
- `*.keytab`
- `*.pem`
- `*.jks`
