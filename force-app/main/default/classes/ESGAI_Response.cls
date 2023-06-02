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
public with sharing class ESGAI_Response {
    @AuraEnabled public String id;
    // public String object {get; set;} // This is keyword object in APEX cannot be used commenetd for info only
    @AuraEnabled public Integer created;
    @AuraEnabled public String model;
    @AuraEnabled public List<ESGAI_Choice > choices;
    @AuraEnabled public ESGAI_Usage usage;

    public ESGAI_Response() {}

    public static ESGAI_Response parse(String json) {
        return (ESGAI_Response) System.JSON.deserialize(json, ESGAI_Response.class);
    }

    public class ESGAI_Choice {
        @AuraEnabled public String text;
        @AuraEnabled public Integer index;
        @AuraEnabled public Double logprobs;
        @AuraEnabled public String finish_reason;

        public ESGAI_Choice(){}
    }

    public class ESGAI_Usage {
        @AuraEnabled public Integer prompt_tokens;
        @AuraEnabled public Integer completion_tokens;
        @AuraEnabled public Integer total_tokens;

        public ESGAI_Usage(){}
    }    
}