public with sharing class ESGAI_ModelListWrapper {
        // public String object; // list  object keyword not allowed in APEX
        @AuraEnabled  public List<ESGAI_Model> data;

        public static ESGAI_ModelListWrapper parse(String json) {
            return (ESGAI_ModelListWrapper) System.JSON.deserialize(json, ESGAI_ModelListWrapper.class);
        }
}