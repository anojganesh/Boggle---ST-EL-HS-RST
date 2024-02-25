"implementation of class Boggle below"

'From Pharo10.0.0 of 15 March 2023 [Build information: Pharo-10.0.0+build.538.sha.179ef655ae2b150009a860b127aa3605366659ca (64 Bit)] on 24 February 2024 at 2:44:38.97 pm'!
Object subclass: #Boggle
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'CPS506'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Boggle class
	instanceVariableNames: ''!

!Boggle class methodsFor: 'as yet unclassified' stamp: 'AnojGaneshalingam 2/24/2024 14:23'!
search: board for: wordlist
	"comment stating purpose of class-side method"
	"scope: class-variables  &  class-instance-variables"
	
	| result dict |
	dict := Dictionary new.
	
	wordlist do: [ :word |
			"Transcript show: '=== New word ==='; cr."
		 	result := self searchWord: word in: board.
			(result isNil) ifFalse: [ 
					dict at: word put: result.
				 ]. 
		 ].
	
	
	^dict
	"Transcript show: 'fin'."! !

!Boggle class methodsFor: 'as yet unclassified' stamp: 'AnojGaneshalingam 2/24/2024 14:21'!
searchAdjacentFor: word in: board withRow: prevRowIndex withCol: prevColIndex points: pointsArray
		| firstLetter newPointsArray newWord newBoard result|
		result := nil.
		(word isNotEmpty) ifTrue: [
				firstLetter := word at: 1.
			]
			ifFalse: [
				(pointsArray size = 1) 
				ifTrue: [ "for one letter word cases"
						^pointsArray
					]
				ifFalse: [
					firstLetter := $~. "arbitrary value that will never exist on board"
				]
				
			].
		
		"Transcript show: firstLetter; cr.	
		Transcript show: board; cr.	"
		board doWithIndex: [:row :rowindex | 
        row doWithIndex: [:colLetter :colindex |
            (firstLetter = colLetter) ifTrue: [  "found matching board letter"
					"Transcript show: 'found matching board letter'; cr.	"
					(((colindex - prevColIndex) >= -1 	"is adjacent to previous point"
					and: (colindex - prevColIndex) <= 1) 
    				and: [(rowindex - prevRowIndex) >= -1 
					and: (rowindex - prevRowIndex) <= 1]) 
				
					ifTrue: [
							"Transcript show: 'is adjacent to previous point'; cr.	"
							newPointsArray := pointsArray deepCopy.
							newPointsArray add: (rowindex @ colindex).	
							
							(word size = 1) ifTrue: [ 	"return points if only one letter left"
								"Transcript show: newPointsArray; cr.	"
								^newPointsArray.	
							 ].
						
							newWord := word allButFirst.
							newBoard := board deepCopy.
							(newBoard at: rowindex) at: colindex put: nil.	
								
							result := self searchAdjacentFor: newWord 
							in: newBoard 
							withRow: rowindex 
							withCol: colindex 
							points: newPointsArray.

					].
				].
        ]. 
    ].  

	(result isNotNil) ifTrue: [
			^result
		].
		^nil "Return nil, if nothing is found"! !

!Boggle class methodsFor: 'as yet unclassified' stamp: 'AnojGaneshalingam 2/24/2024 12:51'!
searchWord: word in: board
    | firstLetter foundIndexes result point newBoard newWord |
    firstLetter := word at: 1.
    foundIndexes := OrderedCollection new.
		
    board doWithIndex: [:row :rowindex | 
        row doWithIndex: [:colLetter :colindex |
            (firstLetter = colLetter) ifTrue: [
                "Transcript show: colLetter; cr."
					 point := rowindex @ colindex.
					 foundIndexes add: point.
				    "Transcript show: point; cr."
					"found first letter of word in board."
					"Need algorithm to find adjacent valid board blocks"
					newBoard := board deepCopy.
              	(newBoard at: rowindex) at: colindex put: nil.	
					newWord := word allButFirst.
					result := (
						self searchAdjacentFor: newWord 
						in: newBoard 
						withRow: rowindex 
						withCol: colindex
						points: foundIndexes
						).
					(result notNil) ifTrue: [ 
						result := result asArray.
						"Transcript show: result; cr."
						^result  "convert to array and dictionary with word later"
					].
					foundIndexes := OrderedCollection new.
            ].
        ].
    ].
	^nil! !
