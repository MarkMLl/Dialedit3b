unit NewDlgs;

interface

uses Objects, Views, Dialogs;

(*
	ÉÍ[þ]ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ Specify an Adder Tree ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	º±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±AddTree can generate adder trees for any of the following patterns:±º
	º±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±± Input Pattern ±±±±"Correlator" assumes that inputs have been±±±±±±±º
	º±± ( ) Correlator ±±±conditionally negated, and therefore have±±±±±±±±º
	º±± ( ) Summer     ±±±two least-significant bits each.±±±±±±±±±±±±±±±±±º
	º±± (þ) Multiplier ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±± ( ) Squarer    ±±±"Summer" assumes multiple integers are summed.±±±º
	º±± ( ) Arbitrary  ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±±"Multiplier" can sum multiple products.±±±±±±±±±±º
	º±± Input Precision ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±± 4            ÞÝ±±"Squarer" can sum multiple squares.±±±±±±±±±±±±±±º
	º±±±(bits / input)±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±±Use "Arbitrary" to specify any input pattern,±±±±º
	º±± Number of inputs ±listing the number of bits at each signif-±±±±±±±º
	º±± 2            ÞÝ± icance level here, LSB first. ±±±±±±±±±±±±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±± 1 2 3 4 3 2 1                              ÞÝ±±º
	º±± Arithmetic Bias ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±± 0            ÞÝ±±Arithmetic bias and±±±±±± Automatically Compute ±º
	º±±±±±±±±±±±±±±±±±±±±±output precision can be±± [X] Arithmetic Bias  ±±º
	º±± Output Precision ±computed automatically.±± [X] Output Precision ±±º
	º±± 9            ÞÝ±±Use check boxes on the±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±(bits / output)±±±right or input lines on the left.±±±±±±±±±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±± Adder Stages per ± Logic Options ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±Pipeline Level±±±± [X] Generate logic for the adder tree.       ±±±º
	º±± 0            ÞÝ±± [X] Use bit vectors for compact logic specs. ±±±º
	º±±±0= no pipelining±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±± Entity Name  AdderTree                     ÞÝ±±º
	º±± Maximum Carry ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	º±±±Lookahead Span±±±±±±±±±±Generate    Ok   Ü±±±±±±±  Cancel Ü±±±±±±±±º
	º±± 4            ÞÝ±±±±±±±±output    ßßßßßßßß±±±±±±±  ßßßßßßßß±±±±±±±±º
	º±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±º
	ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

*)

{ AdderTreeDialog }

type
	PAdderTreeDialog = ^TAdderTreeDialog;
	TAdderTreeDialog = object(TDialog)
		constructor Init;
	end;

	PAdderTreeData = ^TAdderTreeData;
	TAdderTreeData = record
		Pattern: word;
		Precision: longint;
		Number: longint;
		InBits: string[80];
		Bias: string[12];
		OutBits: longint;
		AutoOpts: word;
		APipe: longint;
		Options: word;
		EntityName: string[80];
		MaxSpan: longint;
	end;

const
	ipCorrelator =	0;  {Pattern values}
	ipSummer =	1;
	ipMultiplier =	2;
	ipSquarer =	3;
	ipArbitrary =	4;
	aoBias =	$1;  {AutoOpts values}
	aoPrec =	$2;
	loGenerate =	$1;  {Options values}
	loVectors =	$2;

const
	AdderTreeDefaults: TAdderTreeData = (
		Pattern: 2;
		Precision: 4;
		Number: 2;
		InBits: '1 2 3 4 3 2 1';
		Bias: '0';
		OutBits: 9;
		AutoOpts: $3;
		APipe: 0;
		Options: $3;
		EntityName: 'AdderTree';
		MaxSpan: 4
	);

implementation

uses Menus, TvInput;

const
	hiPrec =	101;
	hiNumb =	102;
	hiInBits =	103;
	hiBias =	104;
	hiOutB =	105;
	hiPipe =	106;
	hiEntity =	107;
	hiMaxSpan =	108;

{ AdderTreeDialog }

constructor TAdderTreeDialog.Init;
var
	R: TRect;
	IL: PInputLine;
	RB: PRadioButtons;
	CB: PCheckBoxes;
begin
	R.Assign(1, 5, 73, 40);
	inherited Init(R, 'Specify an Adder Tree');
	Options:= Options or ofCentered;

	R.Assign(3, 2, 70, 3);
	Insert(New(PStaticText, Init(R, 'AddTree can generate adder trees for any of the following patterns:')));

	R.Assign(3, 5, 19, 10);
	RB:= New(PRadioButtons, Init(R,
		NewSItem('~C~orrelator',
		NewSItem('~S~ummer',
		NewSItem('~M~ultiplier',
		NewSItem('S~q~uarer',
		NewSItem('~A~rbitrary',
		nil)))))
	));  Insert(RB);
	R.Assign(3, 4, 18, 5);
	Insert(New(PLabel, Init(R, '~I~nput Pattern', RB)));

	R.Assign(3, 12, 17, 13);
	IL:= New(PRangeInputLine, Init(R, 10, 1, 63));  Insert(IL);
	R.Assign(3, 11, 20, 12);
	Insert(New(PLabel, Init(R, 'Input ~P~recision', IL)));
	R.Assign(17, 12, 20, 13);
	Insert(New(PHistory, Init(R, IL, hiPrec)));

	R.Assign(4, 13, 18, 14);
	Insert(New(PStaticText, Init(R, '(bits / input)')));

	R.Assign(3, 16, 17, 17);
	IL:= New(PRangeInputLine, Init(R, 10, 1, MaxLongint));  Insert(IL);
	R.Assign(3, 15, 21, 16);
	Insert(New(PLabel, Init(R, '~N~umber of inputs', IL)));
	R.Assign(17, 16, 20, 17);
	Insert(New(PHistory, Init(R, IL, hiNumb)));

	R.Assign(22, 4, 64, 5);
	Insert(New(PStaticText, Init(R, '"Correlator" assumes that inputs have been')));

	R.Assign(22, 5, 63, 6);
	Insert(New(PStaticText, Init(R, 'conditionally negated, and therefore have')));

	R.Assign(22, 6, 54, 7);
	Insert(New(PStaticText, Init(R, 'two least-significant bits each.')));

	R.Assign(22, 8, 68, 9);
	Insert(New(PStaticText, Init(R, '"Summer" assumes multiple integers are summed.')));

	R.Assign(22, 10, 61, 11);
	Insert(New(PStaticText, Init(R, '"Multiplier" can sum multiple products.')));

	R.Assign(22, 12, 57, 13);
	Insert(New(PStaticText, Init(R, '"Squarer" can sum multiple squares.')));

	R.Assign(22, 14, 67, 15);
	Insert(New(PStaticText, Init(R, 'Use "Arbitrary" to specify any input pattern,')));

	R.Assign(22, 15, 64, 16);
	Insert(New(PStaticText, Init(R, 'listing the number of bits at each signif-')));

	R.Assign(22, 17, 66, 18);
	IL:= New(PInputLine, Init(R, 80));  Insert(IL);
	R.Assign(21, 16, 52, 17);
	Insert(New(PLabel, Init(R, 'icance level ~h~ere, LSB first.', IL)));
	R.Assign(66, 17, 69, 18);
	Insert(New(PHistory, Init(R, IL, hiInBits)));

	R.Assign(3, 19, 17, 20);
	IL:= New(PInputLine, Init(R, 12));  Insert(IL);
	R.Assign(3, 18, 20, 19);
	Insert(New(PLabel, Init(R, 'Arithmetic ~B~ias', IL)));
	R.Assign(17, 19, 20, 20);
	Insert(New(PHistory, Init(R, IL, hiBias)));

	R.Assign(3, 22, 17, 23);
	IL:= New(PRangeInputLine, Init(R, 10, 0, 63));  Insert(IL);
	R.Assign(3, 21, 21, 22);
	Insert(New(PLabel, Init(R, '~O~utput Precision', IL)));
	R.Assign(17, 22, 20, 23);
	Insert(New(PHistory, Init(R, IL, hiOutB)));

	R.Assign(4, 23, 19, 24);
	Insert(New(PStaticText, Init(R, '(bits / output)')));

	R.Assign(22, 19, 41, 20);
	Insert(New(PStaticText, Init(R, 'Arithmetic bias and')));

	R.Assign(22, 20, 45, 21);
	Insert(New(PStaticText, Init(R, 'output precision can be')));

	R.Assign(22, 21, 45, 22);
	Insert(New(PStaticText, Init(R, 'computed automatically.')));

	R.Assign(22, 22, 44, 23);
	Insert(New(PStaticText, Init(R, 'Use check boxes on the')));

	R.Assign(22, 23, 55, 24);
	Insert(New(PStaticText, Init(R, 'right or input lines on the left.')));

	R.Assign(47, 20, 69, 22);
	CB:= New(PCheckBoxes, Init(R,
		NewSItem('Arithmetic ~B~ias',
		NewSItem('~O~utput Precision',
		nil))
	));  Insert(CB);
	R.Assign(47, 19, 70, 20);
	Insert(New(PLabel, Init(R, '~A~utomatically Compute', CB)));

	R.Assign(3, 27, 17, 28);
	IL:= New(PRangeInputLine, Init(R, 10, 0, MaxLongint));  Insert(IL);
	R.Assign(3, 25, 21, 26);
	Insert(New(PLabel, Init(R, 'A~d~der Stages per', IL)));
	R.Assign(17, 27, 20, 28);
	Insert(New(PHistory, Init(R, IL, hiPipe)));

	R.Assign(4, 26, 18, 27);
	Insert(New(PStaticText, Init(R, 'Pipeline Level')));

	R.Assign(4, 28, 20, 29);
	Insert(New(PStaticText, Init(R, '0= no pipelining')));

	R.Assign(28, 31, 36, 33);
	Insert(New(PStaticText, Init(R, 'Generate  output')));

	R.Assign(4, 31, 18, 32);
	Insert(New(PStaticText, Init(R, 'Lookahead Span')));

	R.Assign(22, 26, 68, 28);
	CB:= New(PCheckBoxes, Init(R,
		NewSItem('~G~enerate logic for the adder tree.',
		NewSItem('~U~se bit vectors for compact logic specs.',
		nil))
	));  Insert(CB);
	R.Assign(22, 25, 37, 26);
	Insert(New(PLabel, Init(R, '~L~ogic Options', CB)));

	R.Assign(35, 29, 66, 30);
	IL:= New(PInputLine, Init(R, 80));  Insert(IL);
	R.Assign(22, 29, 35, 30);
	Insert(New(PLabel, Init(R, '~E~ntity Name', IL)));
	R.Assign(66, 29, 69, 30);
	Insert(New(PHistory, Init(R, IL, hiEntity)));

	R.Assign(3, 32, 17, 33);
	IL:= New(PRangeInputLine, Init(R, 4, 2, 9));  Insert(IL);
	R.Assign(3, 30, 18, 31);
	Insert(New(PLabel, Init(R, 'Ma~x~imum Carry', IL)));
	R.Assign(17, 32, 20, 33);
	Insert(New(PHistory, Init(R, IL, hiMaxSpan)));

	R.Assign(53, 31, 63, 33);
	Insert(New(PButton, Init(R, 'Canc~e~l', cmCancel, bfNormal)));

	R.Assign(36, 31, 46, 33);
	Insert(New(PButton, Init(R, '~O~k', cmOK, bfDefault)));
end; {TAdderTreeDialog.Init}

begin end.
