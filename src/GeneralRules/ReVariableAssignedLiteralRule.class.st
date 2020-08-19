"
If a variable is only assigned a single literal value then that variable is either nil or that literal value. If the variable is always initialized with that literal value, then you could replace each variable reference with a message send to get the value. If the variable can also be nil, then you might want to replace that variable with another that stores true or false depending on whether the old variable had been assigned.
"
Class {
	#name : #ReVariableAssignedLiteralRule,
	#superclass : #ReAbstractRule,
	#category : #'GeneralRules-Migrated'
}

{ #category : #'testing-interest' }
ReVariableAssignedLiteralRule class >> checksClass [

	^ true
]

{ #category : #running }
ReVariableAssignedLiteralRule >> check: aClass forCritiquesDo: aCriticBlock [

	(aClass slots, aClass classVariables) do: [ :variable | 
		|  assignmentNodes |
		assignmentNodes := variable  assignmentNodes.
		assignmentNodes size = 1 ifFalse: [ ^ self ].
		assignmentNodes first value isLiteralNode ifTrue: [ 
		aCriticBlock cull: (self critiqueFor: aClass about: variable  name) ]].
]

{ #category : #'running-helpers' }
ReVariableAssignedLiteralRule >> critiqueFor: aClass about: aVarName [

	| crit |
	crit := ReTrivialCritique
		withAnchor: (ReVarSearchSourceAnchor
			entity: aClass
			string: aVarName)
		by: self.
	
	crit tinyHint: aVarName.
				
	^ crit
]

{ #category : #accessing }
ReVariableAssignedLiteralRule >> group [
	^ 'Design Flaws'
]

{ #category : #accessing }
ReVariableAssignedLiteralRule >> name [
	^ 'Variable is only assigned a single literal value'
]