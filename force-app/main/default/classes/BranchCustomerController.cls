/**
 * @description       : Controller class for BranchCustomer components
 * @author            : PaulJohn.duRand@absa.africa
 * @created           : 2020-10-29
 * @last modified by  : PaulJohn.duRand@absa.africa
 * @last modified by  : PaulJohn.duRand@absa.africa
**/
public without sharing class BranchCustomerController {
    /**
    * @description Gets Custom Metadata Config
    * @author Clifford.Willers@absa.africa | 2022-03-10
    * @param configName
	* @return String
    */
    @AuraEnabled
	public static String getComponentConfig(String configName) {
        return BranchFunctions.getComponentConfig(configName);
    }
    /**
    * @description Method where a list of fields can be send to be validated by CVS. List<Map<String,String>> The map entry of the must have a ServiceField ,CMPField and Value
    * @return Map<String,String>
    * @param accountID
    * @param fieldsToValidate
    */
    @AuraEnabled
    public static Map<String,String> validateFields(String accountID, List<Map<String,String>> fieldsToValidate)
    {
        Map<String,String> outPut = CVSServicesHelper.validateFields(accountID, fieldsToValidate);
        return outPut;
    }
    /**
    * @description getFieldPickListValues
    * @author Clifford.Willers@absa.africa | 2022-03-03
    * @return List<String>
    * @param objObject
    * @param objField
    */
    @AuraEnabled
    public static List<String> getFieldPickListValues(SObject objObject, String objField)
    {
        return BranchFunctions.getFieldPickListValues(objObject, objField);
    }
    /**
    * @description getFieldPickListValueMap
    * @author Clifford.Willers@absa.africa | 2022-03-03
    * @return List<Map<String, String>>
    * @param objObject
    * @param objField
    */
    @AuraEnabled
    public static List<Map<String, String>> getFieldPickListValueMap(SObject objObject, String objField)
    {
        return BranchFunctions.getFieldPickListValueMap(objObject, objField);
    }
    /**
    * @description getFieldPickListValueMap
    * @author Clifford.Willers@absa.africa | 2022-03-03
    * @return List<Map<String, String>>
    * @param objObject
    * @param objField
    * @param excludeValues
    */
    @AuraEnabled
    public static List<Map<String, String>> getFieldPickListValueMap(SObject objObject, String objField, List<String> excludeValues)
    {
        return BranchFunctions.getFieldPickListValueMap(objObject, objField, excludeValues);
    }
    /**
    * @description get Translation List Values for Individual
    * @return List<String>
    * @param systemName
    * @param valueType
    * @param direction
    */
    @AuraEnabled
    public static List<String> getTranslationListValues(String systemName, String valueType, String direction)
    {
        return BranchFunctions.getTranslationValues(systemName, valueType, direction);
    }
    /**
    * @description get Translation List Values by Client Type
    * @return List<String>
    * @param systemName
    * @param valueType
    * @param direction
    * @param clientType
    */
    @AuraEnabled
    public static List<String> getTranslationListValues(String systemName, String valueType, String direction, String clientType)
    {
        return BranchFunctions.getTranslationValues(systemName, valueType, direction, clientType);
    }
    /**
    * @description get Translation Values for Individual
    * @return Map<String,String>
    * @param systemName
    * @param valueType
    * @param direction
    * @param objObject
    * @param objField
    */
    @AuraEnabled
    public static Map<String,String> getTranslationValues(String systemName, String valueType, String direction, SObject objObject, String objField)
    {
        return BranchFunctions.getValidTranslations(systemName, valueType, direction, objObject, objField);
    }
    /**
    * @description get Translation Values by Client Type
    * @return Map<String,String>
    * @param systemName
    * @param valueType
    * @param direction
    * @param objObject
    * @param objField
    * @param clientType
    */
    @AuraEnabled
    public static Map<String,String> getTranslationValues(String systemName, String valueType, String direction, SObject objObject, String objField, String clientType)
    {
        return BranchFunctions.getValidTranslations(systemName, valueType, direction, objObject, objField, clientType);
    }
    /**
    * @description getAddress
    * @return Map<String,String>
    * @param recordId
    * @param requestedAddressTypeList
    */
    @AuraEnabled
    public static Map<String, String> getAddress(String recordId, List<String> requestedAddressTypeList)
    {
        return BranchCustomerAddressHelper.getAddresses(recordId, requestedAddressTypeList);
    }
    /**
    * @description createMaintenanceCase
    * @return String
    * @param recordId
    */
    @AuraEnabled
    public static String createMaintenanceCase(String recordId)
    {
        return CustomerCaseController.createServiceRequestCase(recordId, 'Retail Banking', 'Customer Maintenance');
    }
    /**
    * @description updateMaintenanceCase
    * @return String
    * @param caseId
    * @param caseStatus
    */
    @AuraEnabled
    public static String updateMaintenanceCase(String caseId, String caseStatus)
    {
        return CustomerCaseController.updateCaseStatus(caseId, caseStatus);
    }
    /**
    * @description getForeignTaxData
    * @return List<IdentityDocument>
    * @param recordId
    */
    @AuraEnabled
    public static List<IdentityDocument> getForeignTaxData(String recordId)
    {
        String recordType = 'Foreign Tax';
        return ForeignTaxDataTableController.getTaxDocuments(recordId, recordType);
    }
    /**
    * @description getForeignTaxCVSData
    * @return String
    * @param jsonString
    */
    @AuraEnabled
    public static String getForeignTaxCVSData(String jsonString)
    {
        return ForeignTaxDataTableController.getForeignTaxCVSData(jsonString);
    }
    /**
    * @description updateTaxDocuments
    * @param jsonString
    */
    @AuraEnabled
    public static void updateTaxDocuments(String jsonString)
    {
        ForeignTaxDataTableController.updateTaxDocuments(jsonString);
    }
    /**
    * @description deleteTaxDocuments
    * @param jsonString
    */
    @AuraEnabled
    public static void deleteTaxDocuments(String jsonString)
    {
        ForeignTaxDataTableController.deleteTaxDocuments(jsonString);
    }
    /**
    * @description createOrUpdate
    * @return String
    * @param objId
    */
    @AuraEnabled
    public static String createOrUpdate(String objId)
    {
        return CVSServicesHelper.createOrUpdate(objId);
    }
    /**
     * @description get credit consent labels
     * @return Map<String, String>
     */
    @AuraEnabled
    public static Map<String, String> getCreditConsent(){
        Map<String, String> options = new Map<String, String>();
        //get makertingconsent Industry Field Describe
        Schema.DescribeFieldResult fieldResult = Contact.Credit_Marketing_Indicator__c.getDescribe();
        //get  makertingconsent Picklist Values
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            //Put Picklist Value & Label in Map
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }

    /**
     * @description get non credit consent labels
     * @return Map<String, String>
     */
    @AuraEnabled
    public static Map<String, String> getNonCreditConsent(){
        Map<String, String> options = new Map<String, String>();
        //get Account makertingconsent Field Describe
        Schema.DescribeFieldResult fieldResult = Contact.Non_Credit_Marketing_Indicator__c.getDescribe();
        //get Account makertingconsent Picklist Values
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            //Put Picklist Value & Label in Map
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    /**
    * @description getProcessDetails
    * @return String
    * @param caseId
    * @param onboardingMode
    */
    @AuraEnabled
    public static String getProcessDetails(String caseId, String onboardingMode)
    {
        ProductProcess.ProcessDetails processDetail = new ProductProcess.ProcessDetails();
        processDetail.name = '';
        processDetail.flow = 'CustomerMaintenanceKYCFulfilment';
        processDetail.onboardingMode = onboardingMode;
        processDetail.productAccountNumber = '';
        processDetail.productFamily = '';
        processDetail.productSelectorMode = '';
        processDetail.requestName = '';
        processDetail.caseId = caseId;
        processDetail.ProcessType = ProductProcess.ProcessType.CustomerMaintenance;
        return JSON.serialize(processDetail);
    }

    /**
    * @description validateId
    * @author PaulJohn.duRand@absa.africa | 2021-11-22
    * @param idNumber
    * @return Boolean
    **/
    @AuraEnabled
    public static Boolean validateId(String idNumber) {
        return SystemValidationUtils.validate(SystemValidationUtils.type.RSA_ID_NUMBER, idNumber);
    }
}