# Metric: Series

## Description

Returns a list of **series** for the metric.

Each series is identified by metric name, entity name, and optional series tags.

## Request

| **Method** | **Path** |
|:---|:---|
| GET | `/api/v1/metrics/{metric}/series` |

### Path Parameters

| **Name** | **Description** |
|:---|:---|
| metric | **[Required]** Metric name. |

### Query Parameters

| **Parameter** |**Type**| **Description** |
|:---|:---|:---|
| entity | string| Filter series collected by the specified entity name. |
| tags.{tag=name} | string | Filter series that contain the specified series tag values.<br>Example: `?tags.mount_point=/` or `?entity=nurswgvml007&tags.mount_point=/`|
| minInsertDate |string|Filter series with `lastInsertDate` equal or greater than `minInsertDate`.<br>`minInsertDate` can be specified in ISO format or using [endtime](../../../end-time-syntax.md) syntax.|
| maxInsertDate |string|Filter series with `lastInsertDate` less than `maxInsertDate`.<br>`maxInsertDate` can be specified in ISO format or using [endtime](../../../end-time-syntax.md) syntax.|
| addMeta | boolean | Include metric and entity metadata (fields and tags) under the `meta` object in the response. Default: `false`.|

## Response

### Fields

| **Field** | **Description** |
|:---|:---|
| metric | Metric name.  |
| entity | Entity name.  |
| tags | An object containing **series** tag names and values.<br>For example, `"tags": {"file_system": "/dev/sda"}` |
| lastInsertDate |Last time a value was received for this series. ISO date.|

### Errors

None.

## Example

### Request

#### URI

```elm
GET https://atsd_host:8443/api/v1/metrics/disk_used/series
```

#### Payload

None.

#### curl

```elm
curl https://atsd_host:8443/api/v1/metrics/disk_used/series \
  --insecure --verbose --user {username}:{password} \
  --request GET
```

### Response

```json
[{
	"metric": "disk_used",
	"entity": "nurswgvml007",
	"tags": {
		"file_system": "/dev/mapper/vg_nurswgvml007-lv_root",
		"mount_point": "/"
	},
	"lastInsertDate": "2016-05-23T11:54:36.000Z"
}, {
	"metric": "disk_used",
	"entity": "nurswgvml006",
	"tags": {
		"file_system": "10.102.0.2:/home/store/share",
		"mount_point": "/mnt/share"
	},
	"lastInsertDate": "2015-12-25T14:09:49.000Z"
}]
```

## Additional Examples

* Filter series with tag `file_system` equal to `/`.

```elm
/api/v1/metrics/disk_used/series?entity=nurswgvml007&tags.file_system=/
```
