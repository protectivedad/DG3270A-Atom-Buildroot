##-----------------------------------------------------------------------------
## Copyright (c) 2008-2013 Intel Corporation
##
## DISTRIBUTABLE AS SAMPLE SOURCE SOFTWARE
##
## This Distributable As Sample Source Software is subject to the terms and
## conditions of the Intel Software License Agreement provided with the Intel(R)
## Media Processor Software Development Kit.
##-----------------------------------------------------------------------------
echo '-------------------------------------------------'
echo '************ AES ********************************'
echo '-------------------------------------------------'
./aes

echo '-------------------------------------------------'
echo '************ DES ********************************'
echo '-------------------------------------------------'
./des

echo '-------------------------------------------------'
echo '************ KEY CACHE **************************'
echo '-------------------------------------------------'
./key_cache

echo '-------------------------------------------------'
echo '************ MISC *******************************'
echo '-------------------------------------------------'
./misc

echo '-------------------------------------------------'
echo '************ MD5 ********************************'
echo '-------------------------------------------------'
./md5 ./md5

echo '-------------------------------------------------'
echo '************ RSA CRYPT **************************'
echo '-------------------------------------------------'
./rsa_crypt

echo '-------------------------------------------------'
echo '************ RSA SIGN/VERIFY ********************'
echo '-------------------------------------------------'
./rsa_sign_verify_md

echo '-------------------------------------------------'
echo '************ SHA ********************************'
echo '-------------------------------------------------'
./sha

echo '-------------------------------------------------'
echo '************ ARC4 *************************'
echo '-------------------------------------------------'
./arc4

echo '-------------------------------------------------'
echo '************ WRAP_KE *************************'
echo '-------------------------------------------------'
./wrap_ke ke.bin wrapped_ke.bin
