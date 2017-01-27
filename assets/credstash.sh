get_secret() {
  table=${1} # DynamoDB table, the secret is stored in.
  region=${2} # Region, the KMS and Table exist in.
  secret=${3} # Name of the secret stored to be obtained.

  credstash -t ${table} -r ${region} get ${secret}
}

set_secret() {
  table=${1} # DynamoDB table, the secret will be stored in.
  region=${2} # Region, the KMS and Table exist in.
  encryption_key=${3} # KMS, the secret should be encrypted with.
  secret=${4} # Name of the secret to be stored as.
  value=${5} # Value of the secret to be stored.

  credstash -t ${table} -r ${region} put -k ${encryption_key} ${secret} ${value}
}
