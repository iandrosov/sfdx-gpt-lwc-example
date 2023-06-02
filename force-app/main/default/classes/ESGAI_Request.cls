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
 * Request class encpsulates GPT request data with status code.
 * Serve as class wrapper to generate OpenAI API requests.
 */
public with sharing class ESGAI_Request {
    public String model {get;set;}
    public String prompt {get; set;}
    public Decimal temperature {get; set;}
    public Integer max_tokens {get; set;}
    public Decimal top_p {get; set;}
    public Decimal frequency_penalty {get; set;}
    public Decimal presence_penalty {get; set;}

    public ESGAI_Request() {
        this.model = 'text-davinci-003'; //'gpt-3.5-turbo';
        this.temperature = 0.3;
        this.max_tokens = 150;
        this.top_p = 1.0;
        this.frequency_penalty = 0.0;
        this.presence_penalty = 0.0;
    }

    public ESGAI_Request(String prompt) {
        this.model = 'text-davinci-003'; //'gpt-3.5-turbo';
        this.temperature = 0.3;
        this.max_tokens = 150;
        this.top_p = 1.0;
        this.frequency_penalty = 0.0;
        this.presence_penalty = 0.0;
        this.prompt = prompt;
    }

    public String getJSONString(){
        return JSON.serializePretty(this, true);
    }
}