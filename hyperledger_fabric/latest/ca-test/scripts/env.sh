#!/usr/bin/env bash


DEFAULT_USER="boot-admin"
DEFAULT_PASS="boot-pass"

# store the default template for fabric-ca-server-config.yaml
CA_SERVER_DEFAULT_CONFIG=""
read -r -d '' CA_SERVER_DEFAULT_CONFIG << EOF
version: 1.4.0

port: 7054

debug: false

crlsizelimit: 512000

tls:
  enabled: false
  certfile:
  keyfile:
  clientauth:
    type: noclientcert
    certfiles:

ca:
  name:
  keyfile:
  certfile:
  chainfile:

crl:
  expiry: 24h

registry:
  maxenrollments: -1

  identities:
     - name: ${DEFAULT_USER}
       pass: ${DEFAULT_PASS}
       type: client
       affiliation: ""
       attrs:
          hf.Registrar.Roles: "*"
          hf.Registrar.DelegateRoles: "*"
          hf.Revoker: true
          hf.IntermediateCA: true
          hf.GenCRL: true
          hf.Registrar.Attributes: "*"
          hf.AffiliationMgr: true

db:
  type: sqlite3
  datasource: fabric-ca-server.db
  tls:
      enabled: false
      certfiles:
      client:
        certfile:
        keyfile:

ldap:
   enabled: false
   url: ldap://<adminDN>:<adminPassword>@<host>:<port>/<base>
   tls:
      certfiles:
      client:
         certfile:
         keyfile:
   attribute:
      names: ['uid','member']
      converters:
         - name:
           value:
      maps:
         groups:
            - name:
              value:

affiliations:
   org1:
      - department1
      - department2
   org2:
      - department1

signing:
    default:
      usage:
        - digital signature
        - cert sign
        - crl sign
      expiry: 87600h
    profiles:
      ca:
         usage:
           - cert sign
           - crl sign
         expiry: 43800h
         caconstraint:
           isca: true
           maxpathlen: 0
      tls:
         usage:
            - signing
            - key encipherment
            - server auth
            - client auth
            - key agreement
         expiry: 87600h

csr:
   cn: fabric-ca-server
   keyrequest:
     algo: ecdsa
     size: 256
   names:
      - C: US
        ST: "North Carolina"
        L:
        O: Hyperledger
        OU: Fabric
   hosts:
     - fabric-ca-server
     - localhost
   ca:
      expiry: 1314000h
      pathlength: 1

idemix:
  rhpoolsize: 1000
  nonceexpiration: 15s
  noncesweepinterval: 15m

bccsp:
    default: SW
    sw:
        hash: SHA2
        security: 256
        filekeystore:
            keystore: msp/keystore

cacount:

cafiles:

intermediate:
  parentserver:
    url:
    caname:
  enrollment:
    hosts:
    profile:
    label:
  tls:
    certfiles:
    client:
      certfile:
      keyfile:
EOF

#echo "${CA_SERVER_DEFAULT_CONFIG}"
