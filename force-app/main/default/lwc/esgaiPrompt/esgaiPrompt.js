import { LightningElement , api, wire } from "lwc";
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getGeneratedContent from '@salesforce/apex/ESGAI_PromptCtrl.getGeneratedContent';
import getModels from '@salesforce/apex/ESGAI_PromptCtrl.getModels';
export default class EsgaiPrompt extends LightningElement {
	@api generativeResult;
	@api recordId;
	@api objectApiName;
    isLoading = false;
    title = 'New ideas';
    requestPromtText = '';
    error;
    selectedText = 'Text sample';
    modelOptions = [];
    selectedModelURL = '';

	closeModal() {
		this.dispatchEvent(new CloseActionScreenEvent());
	}
    handlePromptChange(event) {
        this.requestPromtText = event.target.value;
    }
    handleModelChange(event){
        this.selectedModelURL = event.detail.value;
    }
    connectedCallback() {
        this.getLLMModels();
    }
    /*
    @wire(getModels)
    wireModels({error,data}){
        if (data && data.length > 0) {
            console.log('### getModels: '+JSON.stringify(data))
            for(let i=0; i<data.length; i++)  {
                this.modelOptions = [...this.modelOptions ,{value: this.data[i].id , label: data[i].id} ];                                   
            }                
            this.error = undefined;
        }else if(error){
            console.log(error);
            this.error = error;
        }else{
            // eslint-disable-next-line no-console
            console.log('unknown error')
        }
    }
    */
    getLLMModels(){
        this.isLoading = true;
        getModels()
        .then((data) => {
            if (data && data.length > 0) {
                console.log('### getModels: '+JSON.stringify(data))
                for(var i=0; i<data.length; i++)  {
                    console.log(`## MODEL ID: ${this.data[i].id}`);
                    this.modelOptions = [...this.modelOptions, {value: this.data[i].id , label: data[i].id} ];   
                                                    
                }                
                this.error = undefined;
            }else{
                // Handle error Toast
                this.error = data.error;
                const evt = new ShowToastEvent({
                    title: 'GPT Error response',
                    message: data.error.error.message, // comming from wrapper error class
                    variant: 'error',
                });
                this.dispatchEvent(evt);    
            }
            this.isLoading = false;
        })
        .catch((error) => {
            this.error = error;
            this.generativeResult = undefined;
            this.isLoading = false;
            this.error = result.error;
            const evt = new ShowToastEvent({
                title: 'GPT Error response',
                message: this.error, 
                variant: 'error',
            });
            this.dispatchEvent(evt);    

        });

    }
    // Handle API request to GPT
    handleLLMRequest() {
        this.isLoading = true;
        getGeneratedContent({ requestPromtText: this.requestPromtText, modelURL: this.selectedModelURL })
            .then((result) => {
                if (result.issuccess === true){
                    this.generativeResult = result.data;
                    console.log(`GPT Result: ${this.generativeResult}`);
                    this.error = undefined;
                }else{
                    // Handle error Toast
                    this.error = result.error;
                    const evt = new ShowToastEvent({
                        title: 'GPT Error response',
                        message: result.error.error.message, // comming from wrapper error class
                        variant: 'error',
                    });
                    this.dispatchEvent(evt);    
                }
                this.isLoading = false;
            })
            .catch((error) => {
                this.error = error;
                this.generativeResult = undefined;
                this.isLoading = false;
                this.error = result.error;
                const evt = new ShowToastEvent({
                    title: 'GPT Error response',
                    message: this.error, 
                    variant: 'error',
                });
                this.dispatchEvent(evt);    

            });
    }  

}