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
 * Response class encpsulates GPT response data with status code.
 * Serve as class wrapper to generate OpenAI API response.
 */
public with sharing class ESGAI_Model {
        @AuraEnabled public String id;	//text-davinci-001
        // public String object;	// Example data: model  object keyword not allowed in APEX
        @AuraEnabled public Integer created;	//1649364042
        @AuraEnabled public String owned_by;	//openai
        @AuraEnabled public ESGAI_permission[] permission;
        @AuraEnabled public String root;	//text-davinci-001
        @AuraEnabled public ESGAI_parent parent;

        class ESGAI_permission {
            @AuraEnabled public String id;	//modelperm-MVM5NfoRjXkDve3uQW3YZDDt
            //public String object;	//model_permission Identifier name is reserved: object
            @AuraEnabled public Integer created;	//1669066355
            @AuraEnabled public boolean allow_create_engine;
            @AuraEnabled public boolean allow_sampling;
            @AuraEnabled public boolean allow_logprobs;
            @AuraEnabled public boolean allow_search_indices;
            @AuraEnabled public boolean allow_view;
            @AuraEnabled public boolean allow_fine_tuning;
            @AuraEnabled public String organization;	//*
            //public ESGAI_group group; // Identifier name is reserved: group                                                            
            @AuraEnabled public boolean is_blocking;
        }
        class ESGAI_group {
        }
        class ESGAI_parent {
        }

        public static ESGAI_Model parse(String json){
            return (ESGAI_Model) System.JSON.deserialize(json, ESGAI_Model.class);
        }
    
}