context("PKIplus tests")
test_that("PKIplus library loads", {
  library(PKIplus)
})

test_that("x509 functions work", {
  #skip_on_cran() # Sys.setenv(NOT_CRAN = "true") to disable
  library(PKIplus)
  certFile <- system.file("certs/demo.crt", package="PKIplus")
  # Can a certificate object be initialized from a disk file?
  cert <- PKIplus::PKI.load.cert(file=certFile)
  # Can the subject be extracted from the cert
  subject <- PKIplus::PKI.get.subject(cert)
  expect_match(subject, "CN=Simon Urbanek")
  
  # Can the starting date of the cert be extracted?
  expect_match(format(PKI.get.notBefore(cert), format="%Y-%m-%d %H:%M:%S %Z"), 
               "2012-09-08 19:16:36 GMT")
  
  # Can the expiration date of the cert be extracted?
  expect_match(format(PKI.get.notAfter(cert), format="%Y-%m-%d %H:%M:%S %Z"), 
               "2013-09-08 19:16:36 GMT")

  pk <- PKI.pubkey(cert)
  expect_match(class(pk), "public.key")

})
