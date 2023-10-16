page 50851 "Residency Plac. Result List"
{
    ApplicationArea = All;
    Caption = 'Residency Placement Result List';
    PageType = List;
    SourceTable = "Residency Placement Result New";
    UsageCategory = Lists;
    CardPageId = "Residency Placement Res. Card";
    Editable = false;
    SourceTableView = sorting("Application No") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
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
                }
                field("Other Description"; Rec."Other Description")
                {
                    //Visible = Other;
                    ApplicationArea = All;
                }
                field(Neither; Rec.Neither)
                {
                    ApplicationArea = All;
                }
                field("Secure Position"; Rec."Secure Position")
                {
                    ApplicationArea = All;
                }

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

                field("Place Choice"; Rec."Place Choice")
                {
                    Caption = 'I placed with my:';
                    ApplicationArea = All;
                }
                field("Other Choice Desci."; Rec."Other Choice Desci.")
                {
                    ApplicationArea = all;
                }
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
                field("Participate NRMP SOAP"; Rec."Participate NRMP SOAP")
                {
                    Caption = 'Participate in NRMP Soap?';
                    ApplicationArea = All;
                }
                field("Withdraw NRMP Match"; Rec."Withdraw NRMP Match")
                {
                    Caption = 'Withdraw from NRMP Match';
                    ApplicationArea = All;
                }
                field("Withdraw from CaRMS"; Rec."Withdraw from CaRMS")
                {
                    Caption = 'Did you withdraw from CaRMS';
                    ApplicationArea = All;
                }

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
                field("Did Not Submit Rank Order List"; Rec."Did Not Submit Rank Order List")
                {
                    Caption = 'I did not submit a Rank Order List (ROL)';
                    ApplicationArea = all;
                }
                field("Fam. Medi. ERAS Prgm Applied"; Rec."Fam. Medi. ERAS Prgm Applied")
                {
                    ApplicationArea = All;
                }
                field("Fam. Medi. CaRMS Prgm. Applied"; Rec."Fam. Medi. CaRMS Prgm. Applied")
                {
                    ApplicationArea = all;
                }
                field("Fam. Medi. ERAS intws Offered"; Rec."Fam. Medi. ERAS intws Offered")
                {
                    ApplicationArea = all;
                }
                field("Fam. Med. CaRMS Intws. Offered"; Rec."Fam. Med. CaRMS Intws. Offered")
                {
                    ApplicationArea = all;
                }
                field("Fam. Medi. ERAS intws. Atnded."; Rec."Fam. Medi. ERAS intws. Atnded.")
                {
                    ApplicationArea = all;
                }
                field("Fam. Med. CaRMS Intws. Atnded."; Rec."Fam. Med. CaRMS Intws. Atnded.")
                {
                    ApplicationArea = all;
                }
                field("Fam. Med. ERAS Prgm. Rnkd."; Rec."Fam. Med. ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Fam. Med. CaRMS Prgm. Rnkd."; Rec."Fam. Med. CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. ERAS Prgm. Appld."; Rec."Int. Med. ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. CaRMS Prgm. Appld."; Rec."Int. Med. CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. ERAS Inws. Offrd."; Rec."Int. Med. ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. CaRMS Inws. Offrd."; Rec."Int. Med. CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. ERAS Int. Attended"; Rec."Int. Med. ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. CaRMS Int. Attended"; Rec."Int. Med. CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. ERAS Prgm. Rnkd."; Rec."Int. Med. ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Int. Med. CaRMS Prgm. Rnkd."; Rec."Int. Med. CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }

                field("OB GYN ERAS Prgm. Appld."; Rec."OB GYN ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("OB GYN CaRMS Prgm. Appld."; Rec."OB GYN CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("OB GYN ERAS Inws. Offrd."; Rec."OB GYN ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("OB GYN CaRMS Inws. Offrd."; Rec."OB GYN CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("OB GYN ERAS Int. Attended"; Rec."OB GYN ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("OB GYN CaRMS Int. Attended"; Rec."OB GYN CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("OB GYN ERAS Prgm. Rnkd."; Rec."OB GYN ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("OB GYN CaRMS Prgm. Rnkd."; Rec."OB GYN CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics ERAS Prgm. Appld."; Rec."Pediatrics ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics CaRMS Prgm. Appld."; Rec."Pediatrics CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics ERAS Inws. Offrd."; Rec."Pediatrics ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics CaRMS Inws. Offrd."; Rec."Pediatrics CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics ERAS Int. Attended"; Rec."Pediatrics ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics CaRMS Int. Attended"; Rec."Pediatrics CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics ERAS Prgm. Rnkd."; Rec."Pediatrics ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Pediatrics CaRMS Prgm. Rnkd."; Rec."Pediatrics CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry ERAS Prgm. Appld."; Rec."Psychiatry ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry CaRMS Prgm. Appld."; Rec."Psychiatry CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry ERAS Inws. Offrd."; Rec."Psychiatry ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry CaRMS Inws. Offrd."; Rec."Psychiatry CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry ERAS Int. Attended"; Rec."Psychiatry ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry CaRMS Int. Attended"; Rec."Psychiatry CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry ERAS Prgm. Rnkd."; Rec."Psychiatry ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Psychiatry CaRMS Prgm. Rnkd."; Rec."Psychiatry CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Surgery ERAS Prgm. Appld."; Rec."Surgery ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Surgery CaRMS Prgm. Appld."; Rec."Surgery CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Surgery ERAS Inws. Offrd."; Rec."Surgery ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Surgery CaRMS Inws. Offrd."; Rec."Surgery CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Surgery ERAS Int. Attended"; Rec."Surgery ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Surgery CaRMS Int. Attended"; Rec."Surgery CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Surgery ERAS Prgm. Rnkd."; Rec."Surgery ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Surgery CaRMS Prgm. Rnkd."; Rec."Surgery CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Other ERAS Prgm. Appld."; Rec."Other ERAS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Other CaRMS Prgm. Appld."; Rec."Other CaRMS Prgm. Appld.")
                {
                    ApplicationArea = all;
                }
                field("Other ERAS Inws. Offrd."; Rec."Other ERAS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Other CaRMS Inws. Offrd."; Rec."Other CaRMS Inws. Offrd.")
                {
                    ApplicationArea = all;
                }
                field("Other ERAS Int. Attended"; Rec."Other ERAS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Other CaRMS Int. Attended"; Rec."Other CaRMS Int. Attended")
                {
                    ApplicationArea = all;
                }
                field("Other ERAS Prgm. Rnkd."; Rec."Other ERAS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("Other CaRMS Prgm. Rnkd."; Rec."Other CaRMS Prgm. Rnkd.")
                {
                    ApplicationArea = all;
                }
                field("1st Program Name"; Rec."1st Program Name")
                {
                    ApplicationArea = all;
                }
                field("2nd Program Name"; Rec."2nd Program Name")
                {
                    ApplicationArea = all;
                }
                field("3rd Program Name"; Rec."3rd Program Name")
                {
                    ApplicationArea = all;
                }
                field("4th Program Name"; Rec."4th Program Name")
                {
                    ApplicationArea = all;
                }
                field("5th Program Name"; Rec."5th Program Name")
                {
                    ApplicationArea = all;
                }
                field("1st Program Specialty"; Rec."1st Program Specialty")
                {
                    ApplicationArea = all;
                }
                field("2nd Program Specialty"; Rec."2nd Program Specialty")
                {
                    ApplicationArea = all;
                }
                field("3rd Program Specialty"; Rec."3rd Program Specialty")
                {
                    ApplicationArea = all;
                }
                field("4th Program Specialty"; Rec."4th Program Specialty")
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
                }
                field("Utilize the advisory services"; Rec."Utilize the advisory services")
                {
                    Caption = 'Did you utilize the advisory services of Dr. William Anthony?';
                    ApplicationArea = all;
                }
                field("Lessons Learned"; Rec."Lessons Learned")
                {
                    Caption = 'Tell us what you learned during the residency placement process? Was there something you did that proved to be particularly helpful? Was there anything you wish you had known before applying that you would like to share with the University and other students? We appreciate your feedback, which may be printed anonymously in the Post-Match Feedback guide on Blackboard/Graduate Affairs.  Please type your comments here:';
                    ApplicationArea = all;
                }
                field("Can contact to share info"; Rec."Can contact to share info")
                {
                    Caption = 'Upon request, may we share your contact information with other students and alumni seeking residency placement support, advice, or guidance?';
                    ApplicationArea = all;
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
}