Class {
	#name : #PjHttpRequest,
	#superclass : #Object,
	#instVars : [
		'request'
	],
	#pools : [
		'PjBrowserGlobals'
	],
	#category : #'PjHttpClient-Core'
}

{ #category : #'as yet unclassified' }
PjHttpRequest class >> open: aMethod url: aUrl [

	^ self new
		  open: aMethod url: aUrl;
		  yourself
]

{ #category : #'event handling' }
PjHttpRequest >> addEventListener: anEvent block: aFullBlockClosure [ 
	request addEventListener: anEvent block: aFullBlockClosure
]

{ #category : #'event handling' }
PjHttpRequest >> btoa: aString [
	^ aString asByteArray base64Encoded 
]

{ #category : #accessing }
PjHttpRequest >> header: aCollection [ 
	aCollection keysAndValuesDo: [ :key :value | request setRequestHeader: key put: value ]
]

{ #category : #initialization }
PjHttpRequest >> initialize [ 
	super initialize.
	request := XMLHttpRequest new.
]

{ #category : #initialize }
PjHttpRequest >> open: aMethod url: aUrl [ 
	request open: aMethod url: aUrl
]

{ #category : #processing }
PjHttpRequest >> send: aBody [ 
	request send: aBody
]

{ #category : #accessing }
PjHttpRequest >> timeout: aDuration [ 
	request instVarNamed: #timeout put: aDuration asMilliSeconds
]

{ #category : #'event handling' }
PjHttpRequest >> username: username password: password [
	request setRequestHeader: 'Authorization' value: 'Basic ', (self btoa: username, ':', password)
]
