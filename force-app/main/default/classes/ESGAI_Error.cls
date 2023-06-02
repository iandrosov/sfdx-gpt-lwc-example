
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
 *  Error class encpsulates GPT error data with status code.
 */
public with sharing class ESGAI_Error {
	public class Error {
		@AuraEnabled public String message;
		@AuraEnabled public String type;
		@AuraEnabled public String param;
		@AuraEnabled public Integer code;
	}

	@AuraEnabled public Error error;
	
	public static ESGAI_Error parse(String json) {
		return (ESGAI_Error) System.JSON.deserialize(json, ESGAI_Error.class);
	}
}