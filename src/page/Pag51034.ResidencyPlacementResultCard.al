page 51034 "Residency Placement Res. Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Residency Placement Result New";
    Caption = 'Residency Placement Result';

    layout
    {
        area(Content)
        {
            group("Personal Details")
            {
                field("Application No"; Rec."Application No")//GMCSCOM
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Preferred Email Address"; Rec."Preferred Email Address")
                {
                    ApplicationArea = All;
                }
                field("Preferred Phone Number"; Rec."Preferred Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
            }
            group(Application)
            {
                Editable = isEditable;
                Caption = 'Part 1: Application';
                group("Did you participate in:")
                {
                    Caption = 'Did you participate in:';
                    field("NRMP_ERAS "; Rec."NRMP_ERAS")
                    {
                        ApplicationArea = All;
                    }
                    field(CaRMS; Rec.CaRMS)
                    {
                        ApplicationArea = All;
                    }
                    field(Other; Rec.Other)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if Rec.Other then
                                OtherBool := true
                            else begin
                                OtherBool := false;
                                Rec.Validate("Other Description", '');
                            end;
                        end;
                    }
                    field("Other Description"; Rec."Other Description")
                    {
                        Editable = OtherBool;
                        ApplicationArea = All;
                    }
                    field(Neither; Rec.Neither)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Did you secure a residency position for")
                {
                    Caption = 'Did you secure a residency position for';
                    field("Secure Position"; Rec."Secure Position")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group("Secured Residency Position")
            {
                Editable = iseditable;
                Caption = 'Part 2: I secured a residency position for';//+ + AcademicYearGVar;
                Visible = Rec."Secure Position";
                group("Type of Placement")
                {
                    Caption = 'Type of placement: Please choose from the following:';
                    field("Placement Type_vacant position"; Rec."Placement Type_vacant position")
                    {
                        Caption = 'I agreed to fill a vacant position, starting prior to';
                        ApplicationArea = All;
                    }
                    field("Plac. Type_ERAS_NRMP_Match_Day"; Rec."Plac. Type_ERAS_NRMP_Match_Day")
                    {
                        caption = 'I matched through ERAS/NRMP on Match Day';
                        ApplicationArea = all;
                    }
                    field("Placement Type_NRMP_SOAP"; Rec."Placement Type_NRMP_SOAP")
                    {
                        Caption = 'I matched through the NRMP SOAP';
                        ApplicationArea = all;
                    }
                    field("Placement Type_After_SOAP"; Rec."Placement Type_After_SOAP")
                    {
                        Caption = 'I matched with a program after the SOAP';
                        ApplicationArea = all;
                    }
                    field("Placement Type_Outside_Match"; Rec."Placement Type_Outside_Match")
                    {
                        Caption = 'I accepted a position outside of the match ';
                        ApplicationArea = all;
                    }
                    field("Plac. Type_CarMS_1_Iteration"; Rec."Plac. Type_CarMS_1_Iteration")
                    {
                        Caption = 'I matched through CaRMS: 1st Iteration';
                        ApplicationArea = all;
                    }
                    field("Plac. Type_CarMS_2_Iteration"; Rec."Plac. Type_CarMS_2_Iteration")
                    {
                        Caption = 'I matched through CaRMS: 2nd Iteration';
                        ApplicationArea = all;
                    }
                    field("Placement Type_Other"; Rec."Placement Type_Other")
                    {
                        Caption = 'Other (e.g. SF Match, Military Match, Urology)';
                        ApplicationArea = all;
                    }
                }
                group("Program Info. Position")
                {
                    Caption = 'Program Information:	Where did you secure a residency position?';
                    field("Place Choice"; Rec."Place Choice")
                    {
                        Caption = 'I placed with my:';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if Rec."Place Choice" <> Rec."Place Choice"::Other then begin
                                Rec.validate("Other Choice Desci.", '');
                                ChoiceBool := false
                            end else
                                ChoiceBool := true;
                        end;
                    }
                    field("Other Choice Desci."; Rec."Other Choice Desci.")
                    {
                        Editable = ChoiceBool;
                        ApplicationArea = all;
                    }
                    group("Program Type (Select all that apply)")
                    {
                        Caption = 'Program Type (Select all that apply)';
                        field("Preliminary Program"; Rec."Preliminary Program")
                        {
                            ApplicationArea = ALl;
                        }
                        field("Categorical Program"; Rec."Categorical Program")
                        {
                            ApplicationArea = ALl;
                        }
                        field("Advanced Program"; Rec."Advanced Program")
                        {
                            ApplicationArea = ALl;
                        }
                    }
                }
                group("Program Info. Categorial")
                {
                    Caption = 'Please provide preliminary and/or categorical program information, if applicable:';
                    field("Program Name"; Rec."Program Name")
                    {
                        ApplicationArea = ALl;
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = ALl;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = ALl;
                    }
                    field("Start Date"; Rec."Start Date")
                    {
                        ApplicationArea = ALl;
                    }
                    field("ACGME Program ID"; Rec."ACGME Program ID")
                    {
                        ApplicationArea = ALl;
                    }
                    field(Specialty; Rec.Specialty)
                    {
                        ApplicationArea = ALl;
                    }
                    field(State; Rec.State)
                    {
                        Caption = 'State or Province';
                        ApplicationArea = ALl;
                    }
                    field("End Date"; Rec."End Date")
                    {
                        ApplicationArea = ALl;
                    }
                }
            }//end of part 2
            group("Not Secured Residency Position")
            {
                Editable = isEditable;
                Caption = 'Part 3: I did not secured a residency position for';
                Visible = Rec."Secure Position" = false;
                field("Participate NRMP SOAP"; Rec."Participate NRMP SOAP")
                {
                    Caption = 'Did you participate in the NRMP SOAP?';
                    ApplicationArea = All;
                }
                field("Withdraw NRMP Match"; Rec."Withdraw NRMP Match")
                {
                    Caption = 'Did you withdraw from the NRMP Match?';
                    ApplicationArea = All;
                }
                field("Withdraw from CaRMS"; Rec."Withdraw from CaRMS")
                {
                    Caption = 'Did you withdraw from CaRMS?';
                    ApplicationArea = All;
                }
                group("NRMP or CaRMS")
                {
                    Caption = 'If you withdrew from either the NRMP Match or CaRMS, please select from the explanations below:';
                    field("With_Due To Graduation Delayed"; Rec."With_Due To Graduation Delayed")
                    {
                        Caption = 'My graduation date was delayed and I will not graduate by';
                        ApplicationArea = All;
                    }
                    field("With_Due To NRMP Not Eligible"; Rec."With_Due To NRMP Not Eligible")
                    {
                        Caption = 'The NRMP determined that I was not eligible, because:';
                        ApplicationArea = All;
                    }
                    group("I Failed")
                    {
                        Visible = Rec."With_Due To NRMP Not Eligible";

                        field("Withdrew Due To NE_Step2 CS"; Rec."Withdrew Due To NE_Step2 CS")
                        {
                            ApplicationArea = all;
                        }
                        field("Withdrew Due To NE_Step2 CK"; Rec."Withdrew Due To NE_Step2 CK")
                        {
                            ApplicationArea = all;
                        }
                        field("With_Due To NE_Not Rec. Result"; Rec."With_Due To NE_Not Rec. Result")
                        {
                            ApplicationArea = all;
                        }
                    }
                    field("With_Due To CaRMS Not Eligible"; Rec."With_Due To CaRMS Not Eligible")
                    {
                        Caption = 'CaRMS determined I was not eligible because I did not pass the MCCEE';
                        ApplicationArea = all;
                    }
                    field("Withd_Due To Personal Reason"; Rec."Withd_Due To Personal Reason")
                    {
                        ApplicationArea = all;
                        Caption = 'Personal Reasons';
                    }
                    field("Withdrew Due To Other"; Rec."Withdrew Due To Other")
                    {
                        Caption = 'Other';
                        ApplicationArea = all;
                    }
                }
                group("Healthcare Related Position")
                {
                    Caption = 'Please share any healthcare related position that you have started immediately after graduation or completion of rotations:';
                    field("Healthcare Position"; Rec."Healthcare Position")
                    {
                        Caption = 'Position';
                        ApplicationArea = all;
                    }
                    field("Position Institution"; Rec."Position Institution")
                    {
                        Caption = 'Name of Institution';
                        ApplicationArea = all;
                    }
                    field("Position City"; Rec."Position City")
                    {
                        Caption = 'City';
                        ApplicationArea = all;
                    }
                    field("Position State"; Rec."Position State")
                    {
                        Caption = 'State';
                        ApplicationArea = all;
                    }
                    field("Position Department"; Rec."Position Department")
                    {
                        Caption = 'Department';
                        ApplicationArea = all;
                    }
                    field("Position Start Date"; Rec."Position Start Date")
                    {
                        ApplicationArea = all;
                    }
                    field("Position Projective End Date"; Rec."Position Projective End Date")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group("Application Info")
            {
                Editable = isEditable;
                Caption = 'Part 4: Application Information';
                field("Did Not Submit Rank Order List"; Rec."Did Not Submit Rank Order List")
                {
                    Caption = 'I did not submit a Rank Order List (ROL)';
                    ApplicationArea = all;
                }
                group("Family Medicine")
                {
                    field("Fam. Medic. ERAS Prgm Applied"; Rec."Fam. Medic. ERAS Prgm Applied")
                    {
                        ApplicationArea = All;
                    }
                    field("Fam. Medi. CaRMS Prg. Applied"; Rec."Fam. Medi. CaRMS Prg. Applied")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Medi. ERAS intw Offered"; Rec."Fam. Medi. ERAS intw Offered")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Med. CaRMS Intws. Offered"; Rec."Fam. Med. CaRMS Intw. Offered")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Medi. ERAS intws. Atnded."; Rec."Fam. Medi. ERAS intw. Atnded.")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Med. CaRMS Intws. Atnded."; Rec."Fam. Med. CaRMS Intw. Atnded.")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Med. ERAS Prgm. Rnkd."; Rec."Fam. Med. ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Fam. Med. CaRMS Prgm. Rnkd."; Rec."Fam. Med. CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Internal Medicine")
                {
                    field("Int. Med. ERAS Prgm. Appld."; Rec."Int. Med. ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. CaRMS Prgm. Appld."; Rec."Int. Med. CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. ERAS Int. Offrd."; Rec."Int. Med. ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. CaRMS Inws. Offrd."; Rec."Int. Med. CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. ERAS Int. Attended"; Rec."Int. Medi. ERAS Int. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. CaRMS Int. Attended"; Rec."Int. Medi. CaRMS Int. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. ERAS Prgm. Rnkd."; Rec."Int. Med. ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Int. Med. CaRMS Prgm. Rnkd."; Rec."Int. Med. CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group("OB/GYN")
                {
                    field("OB GYN ERAS Prgm. Appld."; Rec."OB GYN ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN CaRMS Prgm. Appld."; Rec."OB GYN CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN ERAS Inws. Offrd."; Rec."OB GYN ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN CaRMS Inws. Offrd."; Rec."OB GYN CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN ERAS Int. Attended"; Rec."OB GYN ERAS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN CaRMS Int. Attended"; Rec."OB GYN CaRMS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN ERAS Prgm. Rnkd."; Rec."OB GYN ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("OB GYN CaRMS Prgm. Rnkd."; Rec."OB GYN CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Pediatrics)
                {
                    field("Pediatrics ERAS Prgm. Appld."; Rec."Pediatrics ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics CaRMS Prgm. Appld."; Rec."Pediatrics CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics ERAS Inws. Offrd."; Rec."Pediatrics ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics CaRMS Inws. Offrd."; Rec."Pediatrics CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics ERAS Int. Attended"; Rec."Pediatrics ERAS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics CaRMS Int. Attended"; Rec."Pediatris CaRMS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics ERAS Prgm. Rnkd."; Rec."Pediatrics ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Pediatrics CaRMS Prgm. Rnkd."; Rec."Pediatrics CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Psychiatry)
                {
                    field("Psychiatry ERAS Prgm. Appld."; Rec."Psychiatry ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry CaRMS Prgm. Appld."; Rec."Psychiatry CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry ERAS Inws. Offrd."; Rec."Psychiatry ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry CaRMS Inws. Offrd."; Rec."Psychiatry CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry ERAS Int. Attended"; Rec."Psychiatry ERAS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry CaRMS Int. Attended"; Rec."Psychitry CaRMS Int. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry ERAS Prgm. Rnkd."; Rec."Psychitry ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Psychiatry CaRMS Prgm. Rnkd."; Rec."Psychitry CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group(Surgery)
                {
                    field("Surgery ERAS Prgm. Appld."; Rec."Surgery ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery CaRMS Prgm. Appld."; Rec."Surgery CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery ERAS Inws. Offrd."; Rec."Surgery ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery CaRMS Inws. Offrd."; Rec."Surgery CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery ERAS Int. Attended"; Rec."Surgery ERAS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery CaRMS Int. Attended"; Rec."Surgery CaRMS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery ERAS Prgm. Rnkd."; Rec."Surgery ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Surgery CaRMS Prgm. Rnkd."; Rec."Surgery CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Other Application Info")
                {
                    Caption = 'Other';
                    field("Other ERAS Prgm. Appld."; Rec."Other ERAS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Other CaRMS Prgm. Appld."; Rec."Other CaRMS Prg. Appld.")
                    {
                        ApplicationArea = all;
                    }
                    field("Other ERAS Inws. Offrd."; Rec."Other ERAS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Other CaRMS Inws. Offrd."; Rec."Other CaRMS Int. Offrd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Other ERAS Int. Attended"; Rec."Other ERAS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Other CaRMS Int. Attended"; Rec."Other CaRMS Inte. Attended")
                    {
                        ApplicationArea = all;
                    }
                    field("Other ERAS Prgm. Rnkd."; Rec."Other ERAS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                    field("Other CaRMS Prgm. Rnkd."; Rec."Other CaRMS Prg. Rnkd.")
                    {
                        ApplicationArea = all;
                    }
                }
                group("Top Five Ranked Programs")
                {
                    Caption = 'Please list your top five ranked programs (Please skip to Part 5 if you did not submit an ROL):';
                    field("1st Program Name"; Rec."1st Program Name")
                    {
                        ApplicationArea = all;
                    }
                    field("1st Program Specialty"; Rec."1st Program Specialty")
                    {
                        ApplicationArea = all;
                    }
                    field("2nd Program Name"; Rec."2nd Program Name")
                    {
                        ApplicationArea = all;
                    }
                    field("2nd Program Specialty"; Rec."2nd Program Specialty")
                    {
                        ApplicationArea = all;
                    }
                    field("3rd Program Name"; Rec."3rd Program Name")
                    {
                        ApplicationArea = all;
                    }
                    field("3rd Program Specialty"; Rec."3rd Program Specialty")
                    {
                        ApplicationArea = all;
                    }
                    field("4th Program Name"; Rec."4th Program Name")
                    {
                        ApplicationArea = all;
                    }
                    field("4th Program Specialty"; Rec."4th Program Specialty")
                    {
                        ApplicationArea = all;
                    }
                    field("5th Program Name"; Rec."5th Program Name")
                    {
                        ApplicationArea = all;
                    }
                    field("5th Program Specialty"; Rec."5th Program Specialty")
                    {
                        ApplicationArea = all;
                    }
                    field("No. of Programs Ranked"; Rec."No. of Programs Ranked")
                    {
                        Caption = 'How many programs did you rank overall?';
                        ApplicationArea = all;
                    }
                    field("Resources Used While Applying"; Rec."Resources Used While Applying")
                    {
                        Caption = 'What resources did you use when choosing the programs to which you applied';
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field("Utilize the advisory services"; Rec."Utilize the advisory services")
                    {
                        Caption = 'Did you utilize the advisory services of Dr. William Anthony?';
                        ApplicationArea = all;
                        Visible = false;
                    }
                }
            }
            group("Part 5: Lessons Learned")
            {
                Editable = isEditable;
                field("Lessons Learned"; Rec."Lessons Learned")
                {
                    Caption = 'Tell us what you learned during the residency placement process? Was there something you did that proved to be particularly helpful? Was there anything you wish you had known before applying that you would like to share with the University and other students? We appreciate your feedback, which may be printed anonymously in the Post-Match Feedback guide on Blackboard/Graduate Affairs.  Please type your comments here:';
                    ApplicationArea = all;
                    MultiLine = true;
                }
                group("share your contact information with other students and alumni")
                {
                    Caption = 'Upon request, may we share your contact information with other students and alumni seeking residency placement support, advice, or guidance?';
                    field("Can contact to share info"; Rec."Can contact to share info")
                    {
                        Caption = 'Upon request, may we share your contact information with other students and alumni seeking residency placement support, advice, or guidance?';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                Caption = 'Student Card';
                Image = Document;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentCard_lPag: Page "Student Detail Card-CS";
                begin
                    Clear(StudentCard_lPag);
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", Rec."Student No.");
                    StudentCard_lPag.SetTableView(StudentMaster_lRec);
                    StudentCard_lPag.Editable := False;
                    StudentCard_lPag.RunModal();
                end;
            }
        }
    }
    var
        OtherBool: Boolean;
        ChoiceBool: Boolean;
        AcademicYearGVar: Code[20];
        isEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        if Rec."Entry From Portal" then
            isEditable := false
        else
            isEditable := true;

        if Rec.Other then
            OtherBool := true
        else begin
            OtherBool := false;
            Rec.Validate("Other Description", '');
        end;
        if Rec."Place Choice" <> Rec."Place Choice"::Other then begin
            Rec.validate("Other Choice Desci.", '');
            ChoiceBool := false
        end else
            ChoiceBool := true;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Place Choice" <> Rec."Place Choice"::Other then begin
            Rec.validate("Other Choice Desci.", '');
            ChoiceBool := false
        end else
            ChoiceBool := true;
    end;


}