DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
cd "$DIR"
pod spec lint incetro-validator.podspec
pod trunk push incetro-validator.podspec