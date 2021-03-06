# Entity Group: Update

## Description

Update fields and tags of the specified entity group. 

Unlike the [replace method](create-or-replace.md), fields and tags that are **not** specified in the request are left unchanged.

Similarly, fields that are set to `null` are ignored and are left unchanged.

## Request

| **Method** | **Path** | **Content-Type Header**|
|:---|:---|---:|
| PATCH | `/api/v1/entity-groups/{group}` | `application/json` |

### Path Parameters 

|**Name**|**Type**|**Description**|
|:---|:---|:---|
| group |string|Entity group name.|

### Fields

Refer to Fields specified in the [Entity Group List](list.md#fields) method.

The `name` field specified in the payload is ignored by the server since it's specified in the path.

## Response

### Fields

None.

## Example

### Request

#### URI

```elm
PATCH https://atsd_host:8443/api/v1/entity-groups/nmon-aix 
```

#### Payload

```json
{
    "tags": {
        "os_type": "AIX"
    }
}
```

#### curl

```elm
curl https://atsd_host:8443/api/v1/entity-groups/nmon-aix \
  --insecure --verbose --user {username}:{password} \
  --header "Content-Type: application/json" \
  --request PATCH \
  --data '{"tags": {"os_type": "AIX"}}
  ```
  
### Response

None.

## Additional examples
