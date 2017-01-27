# Credstash Resource

This is only the proof of concept. It should _NOT_ be used in a production environment...

Reads secrets from [Credstash](https://github.com/fugue/credstash). Authentication is done (by default) using the [KMS IAM policies](https://github.com/fugue/credstash#setting-up-kms), which must be configured before using this resource.

## Source Configuration

|Setting|Description|Required|Sample|Default|
|---:|---:|---:|---:|---:|
|`table`|The DynamoDB table, the credentials are being stored in.|No|`production-cred-store`|`credstash`|
|`encryption_key`|The KMS used, to encrypt and decrypt values.|No|`production-kms`|`credstash`|
|`region`|The region, where DynamoDB and KMS are created.|No|`us-west-2`|`eu-west-1`|
|`secrets`|A name list of secrets, to be dealt with. List should contain one entry, if the `action` is `set`. Otherwise, every item, will get the same value.|No|`- datadog.api_key`|`[]`|
|`value`|A secret value, to be set to the listed secrets. Only applicable on `- set`.|No|`5up3r53cr3tK3y=-`|` `|

### Example

Resource configuration:

``` yaml
  - name: credstash
    type: credstash
    source:
      table: production-credstash
      region: us-west-2
      encryption_key: alias/production
```

Fetching secrets:

``` yaml
- get: datadog
  params:
    secrets:
      - datadog.api_key
      - datadog.app_key
```

Setting secrets:

``` yaml
- set: generated-ssl-certificate
  params:
    secrets:
      - production.web.ssl
    value: TheCertificateContent
```

## Behavior

### `check`: Check for new versions.

Essentially a noop, the current date is always returned as `{"date": "$DATE"}`

### `in`: Read secrets with Credstash

Read any secrets stored in with Credstash.

### `out`: Set secrets with Credstash

Store secrets with Credstash.
