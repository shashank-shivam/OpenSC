#
# PKCS15 r/w profile for Cryptoflex cards
#
cardinfo {
    max-pin-length	= 8;
    pin-encoding	= ascii-numeric;
    pin-pad-char	= 0x00;

    # This is the secure messaging key required for
    # creating files in the MF
    key AUT1 {
        #value		= "=12345678";
        #value		= 2c:15:e5:26:e9:3e:8a:19;
    }
}

# Define reasonable limits for PINs and PUK
# Note that we do not set a file path or reference
# here; that is done dynamically.
PIN user-pin {
    attempts	= 3;
    flags	= 0x32; # local, initialized, needs-padding
}
PIN user-puk {
    attempts	= 10;
}

# Additional filesystem info.
# This is added to the file system info specified in the
# main profile.
filesystem {
    DF MF {
	ACL	= *=AUT1;

	DF PKCS15-AppDF {
	    DF keydir-1 {
		file-id		= 4B01;
		size		= 750;	# Sufficient for a 1024-bit key
		EF pinfile-1 {
    	            file-id		= 0000;
    	            size		= 23;
    	            ACL			= *=NEVER, UPDATE=AUT1;
            	}
		EF template-private-key-1 {
		    file-id		= 0012;
		    ACL			= *=NEVER, CRYPTO=CHV1, UPDATE=AUT1;
		}
                EF template-extractable-key-1 {
    	            file-id		= 7000;
    	            ACL			= *=NEVER, READ=$PIN, UPDATE=AUT1;
                }
            }
	    DF keydir-2 {
		file-id		= 4B02;
		size		= 750;	# Sufficient for a 1024-bit key
		EF pinfile-2 {
    	            file-id		= 0000;
    	            size		= 23;
    	            ACL			= *=NEVER, UPDATE=AUT1;
            	}
		EF template-private-key-2 {
		    file-id		= 0012;
		    ACL			= *=NEVER, CRYPTO=CHV1, UPDATE=AUT1;
		}
                EF template-extractable-key-2 {
    	            file-id		= 7000;
    	            ACL			= *=NEVER, READ=$PIN, UPDATE=AUT1;
                }
            }
	    EF template-public-key-1 {
		file-id		= 5201;
		ACL		= *=AUT1, READ=NONE;
	    }
	    EF template-public-key-2 {
		file-id		= 5202;
		ACL		= *=AUT1, READ=NONE;
	    }
	    EF template-certificate-1 {
		file-id		= 5501;
		ACL		= *=AUT1, READ=NONE;
	    }
	    EF template-certificate-2 {
		file-id		= 5502;
		ACL		= *=AUT1, READ=NONE;
	    }
	}
    }
}

# Define an SO pin
# This PIN is not used yet.
#PIN sopin {
#    file	= sopinfile;
#    reference	= 0;
#}
