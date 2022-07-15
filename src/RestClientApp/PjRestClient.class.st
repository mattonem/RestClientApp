Class {
	#name : #PjRestClient,
	#superclass : #PjFileBasedWebApp,
	#instVars : [
		'client'
	],
	#category : #RestClientApp
}

{ #category : #accessing }
PjRestClient >> start [

	| nameInput sayHelloButton greetingMessageContainer |
	super start.
	client := RestClient new.
	nameInput := document getElementById: #nameTextInput.
	sayHelloButton := document getElementById: #sayHelloButton.
	nameInput
		addEventListener: #change
		block: [ client method: 'GET'; url: nameInput value ].
	greetingMessageContainer := document getElementById:
		                            #greetingMessageContainer.
	client onComplete: [ :reponse | 
			console log: reponse.
			greetingMessageContainer innerHtml: reponse ].
	sayHelloButton addEventListener: #click block: [ 
		client send.
		 ]
]
