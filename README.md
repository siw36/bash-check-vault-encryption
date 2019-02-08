# Check vault encryption
This script checks if every file matching the configured naming pattern is encrypted and gives you helpful output before committing your changes to a git repository.  

## Configuration
__Naming convention filters:__  
Edit the `check_vault.sh` file and add/remove naming patterns to/from the `TYPES` array.  
All array entries will be used to find files matching these pattern.  
Found files will be checked for `ansible-vault` header.  
*Note:* Empty files are ignored.

## Usage
__Manual invocation:__  
Navigate to the git repository where you want to commit changes and exec the script.  

__Automated invocation:__  
Suitable if you want to perform this check every time you want to commit new code to a git repository.  
Set an alias in your `.bashrc` to call this script.  
```bash
# git safe commit
alias gitsc='<path to the script>check_vault.sh'
```

All arguments passed to the script are taken and used for the actual `git commit` command.  
Emaples:  
```bash
# With arguments
gitsc -m "added awesome new code"
```

Make the new alias available in your current shell: `source ~/.bashrc`

Sample output:  
![Image](https://github.com/siw36/bash-check-vault-encryption/blob/master/images/sample_output.png)

## Current matching pattern
- `*vault*`
- `*.keytab`
- `*.pem`
- `*.jks`
