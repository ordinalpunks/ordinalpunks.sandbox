# manman

Manifest Manager in Ruby

* [geraldb.github.com/manman](http://geraldb.github.com/manman)

`manman` calculates MD5 digests/hashes for files listed in manifest template.

## Usage

    manman - Manifest Manager
    
    Usage: manman [options]
        -r, --release RELEASE            Release Version (e.g. 2013.08)
        -e, --env ENV                    Environment (e.g. TEST)
        -u, --valid_until VALID          Valid until (e.g. 2014.01.31)
        -d, --dir PATH                   Path to Packages (default is ./paket)
        -t, --template FILE              Input Template (default is paket.txt.erb)
        -o, --out FILE                   Output File (default is paket.txt)
        -v, --version                    Show version
            --verbose                    Show debug trace
        -h, --help                       Show this message
    
    Examples:
        manman -r 2013.08 -e TEST
        manman -r 2013.08 -e TEST -u 2014.12.31


## Install

Just install the gem:

    $ gem install manman




## MD5 Digest Samples/Notes

### What is MD5?

MD5 is a one-way hashing algorithm for 128 bit (16 byte) digest "signatures" or checksums
(e.g. `bd2e45b8fde5af0ead14ceb80ce3256a`).

### MD5 Digest for Strings

    require 'digest/md5'
    
    digest = Digest::MD5.hexdigest( "Hello MD5 Digest!\n" )
    puts digest
    
    # => bd2e45b8fde5af0ead14ceb80ce3256a


### MD5 Digest for Files

    require 'digest/md5'
    
    digest = Digest::MD5.hexdigest( File.read( ARGV[0] ) )
    puts digest
    
    # => fc2f4ec029715550401c99a188b904b1

### MD5 Digest Calculation in Steps/Chunks

    require 'digest/md5'
    
    all_digest = Digest::MD5.hexdigest( File.read( ARGV[0] ) )
    
    inc_digest = Digest::MD5.new
    file = File.open( ARGV[0], 'r' )
    file.each_line do |line|
      inc_digest.update( line )   # or use <<-alias e.g. inc_digest << line
    end
    
    puts inc_digest.hexdigest
    puts all_digest
    
    # => fc2f4ec029715550401c99a188b904b1
    # => fc2f4ec029715550401c99a188b904b1



## License

The `manman` scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.