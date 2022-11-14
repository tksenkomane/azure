/**
 * @description       : Functions called on the Branch Customer hub cmp
 * @author            : PaulJohn.duRand@absa.africa
 * @last modified on  : 2022-09-16
 * @last modified by  : PaulJohn.duRand@absa.africa
 **/
public class BranchCustomerHubController {
	/**
	 * @description Function to Sync CIF data with salesforce account
	 * @param accId
	 * @author  Paul du Randt
	 * @since   2018-10-10
	 * @return String
	 **/
	@AuraEnabled
	public static Boolean UpdateAccountWithCIF(String accId) {
		try{
			BranchCIFSalesforceSyncHelper.UpdateAccountwithCIF(accId, '', '');
		}catch(Exception ex){
			throw new AuraHandledException(ex.getMessage());
		}
		return isClientNewToProduct(accId);
	}

	/**
	 * @description
	 * @author PaulJohn.duRand@absa.africa | 2022-05-01
	 * @param objId
	 * @return CIgetRelationshipsV20_Resp_IB_v1
	 **/
	@AuraEnabled
	public static String getRelatedParties(String objId) {
		return JSON.serialize(RelatedPartyDetailsController.getRelatedPartyDetails(objId));
	}

	/**
	 * @description
	 * @author PaulJohn.duRand@absa.africa | 2022-05-01
	 * @param relatedParty
	 * @param syncRelatedPartyWithCIF
	 * @return String
	 **/
	@AuraEnabled
	public static String UpdateRelatedPartyAccountWithCIF(String relatedParty, Boolean syncRelatedPartyWithCIF) {
		RelatedPartyDetails relatedPartyDetail = (RelatedPartyDetails) JSON.deserialize(relatedParty, RelatedPartyDetails.class);
		Account relatedPartyAccount;
		if (syncRelatedPartyWithCIF) {
			relatedPartyDetail.accountId = BranchCIFSalesforceSyncHelper.UpdateAccountwithCIF('', relatedPartyDetail.CIFCode, relatedPartyDetail.idNumber);
			relatedPartyAccount = [SELECT PersonContactId, CASA_Reference_Number__c, Name FROM Account WHERE Id = :relatedPartyDetail.accountId LIMIT 1];
		} else {
			relatedPartyAccount = [SELECT Id,PersonContactId, CASA_Reference_Number__c, Name FROM Account WHERE CIF__c = :relatedPartyDetail.CIFCode LIMIT 1];
			relatedPartyDetail.accountId = relatedPartyAccount.Id;
		}
		relatedPartyDetail.contactId = relatedPartyAccount.PersonContactId;
		relatedPartyDetail.actionToPerform = RelatedPartyDetails.action.Unchanged;
		relatedPartyDetail.casaReferenceNumber = relatedPartyAccount.CASA_Reference_Number__c;
		relatedPartyDetail.name = relatedPartyAccount.Name;
		relatedPartyDetail.signatory = true;
		relatedPartyDetail.isVerified = false;
		return JSON.serialize(relatedPartyDetail);
	}

	/**
	 * @description
	 * @author PaulJohn.duRand@absa.africa | 2022-05-01
	 * @param accId
	 * @param relatedList
	 * @return String
	 **/
	@AuraEnabled
	public static String updateAccountContactRelationship(String accId, String relatedList) {
		List<RelatedPartyDetails> relatedPartyDetails = (List<RelatedPartyDetails>) JSON.deserialize(relatedList, List<RelatedPartyDetails>.class);
		return RelatedPartyDetailsController.updateAccountContactRelationship(accId, relatedPartyDetails);
	}

	/**
	 * @description
	 * @author PaulJohn.duRand@absa.africa | 2022-05-01
	 * @param accountId
	 * @return Boolean
	 **/
	@AuraEnabled
	public static Boolean isClientNewToProduct(String accountId) {
		Account acc = [SELECT CIF__c FROM Account WHERE Id = :accountId LIMIT 1];
		if (!String.isBlank(acc.CIF__c)) {
			return true;
		}
		return false;
	}

	/**
	* @description get Context of component metadata
	* @author PaulJohn.duRand@absa.africa | 2022-08-01
	* @return String
	**/
	@AuraEnabled
	public static String getMetaContext() {
		return BranchFunctions.getMetaContext();
	}

	/**
	* @description
	* @author PaulJohn.duRand@absa.africa | 2022-08-04
	* @param configName
	* @return String
	**/
    @AuraEnabled
	public static String getComponentConfig(String configName) {
        return BranchFunctions.getComponentConfig(configName);
    }
}