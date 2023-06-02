/*
 * sfdx-gpt-lwc-example - Salesforce lightning web component using GPT API
 *
 * Copyright © 2023 Igor Androsov
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 * and associated documentation files (the "Software"), to deal in the Software without 
 * restriction, including without limitation the rights to use, copy, modify, merge, publish, 
 * distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the 
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or 
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
 * SOFTWARE.
 * 
 *  Controlle class supports LWC GPT prompt operations.
 *  Example COMPLETION_ENDPOINT https://api.openai.com/v1/completions
 */
public with sharing class ESGAI_PromptCtrl {
    private final static String SF_NAMED_CREDENTIAL = 'callout:ESGAI_API_KEY';
    private final static String OAI_MODEL_ENDPOINT = '/v1/models';
    // Local convinience wrapper class to parse returned results
    public class ESGAI_ResponseWrapper {
        public ESGAI_Response data;
        public ESGAI_Error error;
        public ESGAI_ResponseWrapper(){
            this.data = null;
            this.error = null;
        }
    }
    // Return list of OpenAI Models
    @AuraEnabled
    public static List<ESGAI_Model> getModels(){
        List<ESGAI_Model> modelList = new List<ESGAI_Model>();
        HttpResponse response = calloutGetService(OAI_MODEL_ENDPOINT);
        // Parse the JSON response
        System.debug('GPT Model RESPONSE: ' + response.getStatusCode() + ' Status: ' + response.getStatus());
        String textResult = response.getBody();
        System.debug(response.getBody());
        if (response.getStatusCode() >= 400){
            // Parse error and set error result
            //res.error = ESGAI_Error.parse(textResult);
            System.debug('ERROR Models: '+response);
        } else {
            // Parse result data and set to wrapper object
            ESGAI_ModelListWrapper res = ESGAI_ModelListWrapper.parse(textResult);
            modelList = res.data;
            System.debug('GET Model: ' + textResult);
        }

        return modelList;
    }
    // Send LLM request with user selected model
    @AuraEnabled
    public static List<ESGAI_Response.ESGAI_Choice> getGeneratedContent(String requestPromtText, String modelURL){
        //GGW_GPTResponseWrapper response = new GGW_GPTResponseWrapper();
        List<ESGAI_Response.ESGAI_Choice> response = new List<ESGAI_Response.ESGAI_Choice>();
        ESGAI_ResponseWrapper textResult = sendPromptRequest(requestPromtText);
        System.debug('### '+textResult);
        if(textResult.error != null){
            // handle error here
            //response.error = textResult.error;
            //response.issuccess = false;
            System.debug('ERROR GPT: '+textResult.error);
        }else{
            response = textResult.data.choices;
            /*
            // Covert response to blocks data
            List<GGW_ContentBlockWrapper> cbwResultList = new List<GGW_ContentBlockWrapper>();
            for (ESGAI_Response.ESGAI_Choice c : textResult.data.choices){
                GGW_ContentBlockWrapper cbw = new GGW_ContentBlockWrapper();
                cbw.isselected = false;
                cbw.title = 'Generated text '+c.index;
                cbw.displaytext = c.text;
                // Add otehr fields 
                cbwResultList.add(cbw);
            }
            response.issuccess = true;
            response.contentblocks = cbwResultList;*/
        }
        return response;
    }

    public static ESGAI_ResponseWrapper sendPromptRequest(String str){
        ESGAI_ResponseWrapper res = new ESGAI_ResponseWrapper();
        ESGAI_Request sfgpt = new ESGAI_Request(str);
        String payload = sfgpt.getJSONString();
        System.debug('## REQUEST: ' + payload);
        // Call GPT API
        HttpResponse response = calloutPostService(payload, '/v1/completions');

        // Parse the JSON response
        String textResult = response.getBody();
        System.debug(response.getBody());
        if (response.getStatusCode() >= 400){
            // Parse error and set error result
            res.error = ESGAI_Error.parse(textResult);
        } else {
            // Parse result data and set to wrapper object
            res.data = ESGAI_Response.parse(textResult);
        }
        return res;
    } 
    // Generic method helper to make HTTP request
    // POST method
    // Call OpenAI API in synchronous method with payload
    // Parameters: 
    // payload - String  JSON payload for GPT API HTTP request
    // endpoint -  String URL endpoint in form of /v1/completions example
    private static HttpResponse calloutPostService(String payload, String endpoint){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SF_NAMED_CREDENTIAL + endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');        

        System.debug('## GPT POST REQUEST: '+payload);
        // Set the body as a JSON object
        request.setBody(payload);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        System.debug('## POST RESPONSE CODE: ' + response.getStatusCode() + ' Status: ' + response.getStatus());
        System.debug('## POST RESPONSE DATA: ' + response.getBody());
        return response;
    }
    // Generic method helper to make HTTP request
    // GET HTTP method
    // Call OpenAI API in synchronous GET method NO payload
    // Parameters: 
    // endpoint -  String URL endpoint in form of /v1/completions example
    private static HttpResponse calloutGetService(String endpoint){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SF_NAMED_CREDENTIAL + endpoint);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');        

        HttpResponse response = http.send(request);
        // Parse the JSON response
        System.debug('## GET RESPONSE CODE: ' + response.getStatusCode() + ' Status: ' + response.getStatus());
        System.debug('## GET RESPONSE DATA: ' + response.getBody());
        return response;
    }

    /**
     * Update text block selection, wire block to item and copy block text data for display and edits
     * 
     *
    @AuraEnabled
    public static void saveGeneratedSectionTextBlock(String itemid, String sectionid, String gentext){
        // Save new genarated block related to section
        GGW_Content_Block__c cb = new GGW_Content_Block__c();
        cb.name = '[AI Generated Content]';
        cb.Section__c = sectionid;
        cb.Description__c = gentext;
        if(Schema.sObjectType.GGW_Content_Block__c.isCreateable()){
            insert cb;
        }

        // Construct selected Item to update
        GGW_Selected_Item__c item = new GGW_Selected_Item__c();
        item.Id = itemid;
        item.Selected_Block__c = cb.Id;
        item.Text_Block__c = gentext; // Copy rich text from block to item for edits
        if(Schema.sObjectType.GGW_Selected_Item__c.isUpdateable()){
            update item;
        }

    }*/
}