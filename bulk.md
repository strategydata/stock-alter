# Bulk Overview

## mass update script
This section provides an overview of mass update scripts, utility scripts designed for bulk operations such as mass deletion or updating.

### mass_bulk_updateitem.js

This script facilitates the mass update of items with various field IDs.


**output fields**:

- custitem_celigo_etail_channel -> 1
- custitem_celigo_mag2_websites -> 1
- custitem_celigo_mag2_instance -> 302
- custitem_commodity_code -> random code


## schedule script
This section introduces a schedule script designed to operate within Netsuite. Details on its deployment are included to specify frequency and timing.


### ScheduleGenerateCustomer.js
This script is intended for scheduling customer generation with the format YY-MM-DD.


**output fields**:
- customfomr -> 209
- companname -> YY-MM-DD
- subsidiary -> 1
- entitystatus -> 13


## UserEvent script

User event scripts are associated with various records. They are deployed on records, treating the record as an entry point. Different entry points for various records and times are considered, including before record load, before record submit, and after record submit.

### userEvent_hl_bulk_createconsignment.js
This script is designed to create consignments in the bulk-powders sandbox.

**entry point** :after submit


**output fields**:
- ITEM_FULFILLMENT.custbody_blk_hl_consignment_id

**action**:

- Check if the event type is record creation and specific fields are set
- Encode API credentials for authorization
- Set headers for the HTTP request
- Extract shipping address details from the record
- Construct the payload for the Scurri API request
- Add package and item details to the payload
- Loop through each line item in the record and add item details to the payload
- Make a POST request to the Scurri API to create a consignment
- Parse the response from the Scurri API
- If the API call is successful, update the consignment ID field in the NetSuite record

### userEvent_hl_bulk_salesOrderApproval.js
Part of the PayPal auto-invoice process, this script changes the sales order status to "IN PROCESS" for auto-approvals.


**entry point** : after submit

**output fields**:
- SALES_ORDER.orderstatus ->B
- SALES_ORDER.custbody_hl_bulk_shipping_method_name -> shippingMethod Name
- custbody_hl_kw_magento_invoice -> ifInvoice

**actions**:
- Check if the event type is record creation
- Extract relevant field values from the sales order record
- Check conditions to determine if specific actions should be performed
- Lookup display name for the shipping method
- Calculate total discount amount from line items
- Check if payment method contains "paypal" to determine ifinvoice should be generated
- Submit fields to update the sales order record

## workflow

Workflow scripts operate within workflows. Specific workflows can be found under Workflow > List. This section lists various workflow action scripts, with the recommendation to identify the right workflow for a better understanding.

### workflow_hl_bulk_cartonisation_main.js

**actions**:
- Loads active carton records and transforms them into a more accessible format.
- Loads shipping rules for various carriers.
- Gets a random carton from the provided cartons.
- Selects an appropriate carton based on the provided items and available cartons.
- Implementation logic for onAction
- Extracting item dimensions and weights
- Updating the sales order with selected carton information

**output fields**:
- SALES_ORDER.custbody_hl_blk_carton_name
- SALES_ORDER.custbody_hl_blk_carton_num
### workflow_hl_bulk_getManifest.js

**actions** : 
- Encoding credentials to be used in the API request
- Setting up headers for the API request
- Extracting relevant data from the NetSuite record
- Retrieving consignment IDs associated with item fulfillments
- Extracting carrier ID from the NetSuite record
- Constructing the request body for the Scurri API
- Making an API request to generate the manifest on Scurri
- Parsing the API response to extract the manifest identifier
- Updating the NetSuite record with the generated manifest identifier

**output fields**:
- customrecord_hl_blk_manifest.custrecord_hl_blk_manifest
### workflow_hl_bulk_getManifestPDF.js
**actions** :
- Encoding credentials to be used in the API request
- Setting up headers for the API request
- Extracting relevant data from the NetSuite record
- Checking if a manifest is associated with the record
- Making an API request to fetch documents related to the manifest
- Parsing the API response to extract document details
- Updating the NetSuite record with the fetched document details

**output fields**:
- customrecord_hl_blk_manifest.custrecord_hl_blk_pdf
### workflow_hl_bulk_reshipOrder.js
**actions** :
- Get the new record that triggered the workflow action
- Create a dynamic copy of the Sales Order record
- Set a custom field on the Sales Order record
- Loop through each line of the "item" sublist and set the "rate" field to 0
- Save the modified Sales Order record and get its ID
- Submit a field update on the original Sales Order record

**output fields**:
- SALES_ORDER.custbody_blk_hl_reshipordno
- SALES_ORDER.custbody_blk_hl_reshipsrc
- SALES_ORDER.item.rate
### workflow_hl_bulk_zplPrint.js

**actions**:
- Encode credentials for authorization
- Define headers for HTTP requests
- Retrieve necessary information from the NetSuite record
- Retrieve ZPL label from Scurri API
- Send ZPL label to NiceLabel API
- Retrieve tracking number information from Scurri API
- Load the Item Fulfillment record for further updates
- Set ZPL label information on the Item Fulfillment record
- Update package information on the Item Fulfillment record

**output fields**:
- ITEM_FULFILLMENT.custbody_blk_hl_ship_zpl
- ITEM_FULFILLMENT.custbody_hl_scurri_error
- ITEM_FULFILLMENT.package.packageweight
- ITEM_FULFILLMENT.package.packagetrackingnumber