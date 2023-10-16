page 50891 "ISIR File List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "ISIR File";
    Caption = 'ISIR File List';
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Duplicate Removed"; Rec."Duplicate Removed")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Result Matched"; Rec."Result Matched")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Updated In SLcM"; Rec."Updated In SLcM")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("FAFSA ID"; Rec."FAFSA ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    //StyleExpr = BoolColor;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("First Name"; Rec.StudentFirstName)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Last Name"; Rec.StudentLastName)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Middle Name"; Rec.StudentMiddleInitial)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Date of Birth"; Rec.StudentDateOfBirth)
                {
                    ApplicationArea = All;
                    // StyleExpr = BoolColor;
                }
                field("Permanent Mail Address"; Rec.StudentPermMailAddress)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Permanent City"; Rec.StudentPermCity)
                {
                    ApplicationArea = All;
                    StyleExpr = BoolColor;
                }
                field(Zipcode; Rec.StudentPermZipCode)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Permanent State"; Rec.StudentPermState)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Phone No"; Rec.StudentPermPhoneNbr)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Personal Email Address"; Rec.StudentPersonalEmail)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("FAFSA Type"; Rec."FAFSA Type")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }

                field("Orig Name Id"; Rec.OrigNameId)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Trans No."; Rec.TransNbr)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Drivers Lic No"; Rec.StudentDriversLicNbr)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Drivers Lic State"; Rec.StudentDriversLicState)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Citizenship Status"; Rec.StudentCitizenshipStatus)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Alien Reg No"; Rec.StudentAlienRegNbr)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Marital Status"; Rec.StudentMaritalStatus)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student State Legal Residence"; Rec.StudentStateLegalResidence)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student LegalResident Before"; Rec."Student LegalResident Before")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Legal Residence Date"; Rec.StudentLegalResidenceDate)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Student Gender"; Rec.StudentGender)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Selective Service Reg"; Rec.SelectiveServiceReg)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Drug Con Affect Eligibility"; Rec."Drug Con Affect Eligibility")
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Parent1 Highest Grade Lvl"; Rec.Parent1HighestGradeLvl)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("Parent2 Highest Grade Lvl"; Rec.Parent2HighestGradeLvl)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("HS Diploma Or Equivalent"; Rec.HSDiplomaOrEquivalent)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("High School Name"; Rec.HighSchoolName)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("High School City"; Rec.HighSchoolCity)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("High School State"; Rec.HighSchoolState)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("High School Code"; Rec.HighSchoolCode)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field(Filler1; Rec.Filler1)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
                }
                field("ISIR Code"; Rec.ISIRCode)
                {
                    ApplicationArea = All;
                    //StyleExpr = BoolColor;
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
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Upload SalesForce File")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction()
                var
                    SalesForceFileRec: Record "SalesForce File";
                    //  AcceptedSalesforceFileXml: XmlPort "Accepted Salesforce File";
                    Text001Lbl: Label 'Do you want to Upload the "Accepted Students SalesForce File"?';
                //Text002Lbl: Label 'SalesForce File has been Uploaded.';
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        SalesForceFileRec.Reset();
                        if SalesForceRec.FindSet() then
                            SalesForceFileRec.DeleteAll();

                        Commit();
                        XMLPORT.RUN(Xmlport::"Accepted Salesforce File");
                        // message(Text002Lbl);
                        //AcceptedSalesforceFileXml.Run();
                    end else
                        exit;

                end;
            }

            action("SalesForce List")
            {
                Caption = '&Salesforce List';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                Runobject = page "SalesForce File List";
            }

            action("Upload ISIR File")
            {
                Caption = '&Upload ISIR File';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                Runobject = page "ISIR Request Page";
            }
            action("Remove Duplicate")
            {
                Caption = '&Remove Duplicate';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SetupList;
                ApplicationArea = All;
                trigger OnAction()
                Var
                    Text001Lbl: Label 'Do you want to Remove the Duplicate?';
                    Text002Lbl: Label 'Duplicate removed.';
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        ISIRRec.RESET();
                        IF ISIRRec.FINDSET() THEN
                            REPEAT
                                ISIRRec1.SETRANGE("Social Security No.", ISIRRec."Social Security No.");
                                ISIRRec1.FINDSET();
                                IF ISIRRec1.COUNT > 1 THEN
                                    ISIRRec.DELETE();
                            UNTIL ISIRRec.NEXT() = 0;
                        ISIRRec.MODIFYALL("Duplicate Removed", TRUE);
                        message(Text002Lbl);
                    end else
                        exit;
                end;
            }
            action("Match Result")
            {
                Caption = '&Match Result';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Process;
                ApplicationArea = All;
                trigger OnAction()
                Var
                    SalesForceFileRec: Record "SalesForce File";
                    Count1: Integer;
                    Text001Lbl: Label 'Do you want to match and update FSA ID?';
                    Text002Lbl: Label 'Matching compeleted.';
                    Text003Lbl: Label 'There is no record in Salesforce file, Do you still want to continue?';
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        if Rec."Duplicate Removed" = false then
                            Error('Please remove duplicate first');

                        SalesForceFileRec.Reset();
                        SalesForceFileRec.SetRange("Uploaded On", Today());
                        if not SalesForceFileRec.FindFirst() then
                            IF CONFIRM(Text003Lbl, FALSE) THEN BEGIN
                            end else
                                exit;

                        ISIRRec.Reset();
                        ISIRRec.SetRange("Duplicate Removed", true);
                        ISIRRec.SetRange("Result Matched", false);
                        IF ISIRRec.Findset() Then
                            Repeat

                                AccountName := ISIRRec.StudentFirstName + ' ' + ISIRRec.StudentLastName;
                                SalesForceRec.Reset();
                                SalesForceRec.SetFilter("Student Name", '@' + CONVERTSTR(AccountName, '@', '?'));
                                IF not SalesForceRec.FindFirst() Then begin
                                    SalesForceRec1.Reset();
                                    SalesForceRec1.SetFilter("Email Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                                    IF not SalesForceRec1.FindFirst() Then begin
                                        SalesForceRec2.Reset();
                                        SalesForceRec2.SetRange("Date of Birth", ISIRRec.StudentDateOfBirth);
                                        IF not SalesForceRec2.FindFirst() Then begin
                                            SalesForceRec3.Reset();
                                            SalesForceRec3.SetRange("Phone No", ISIRRec.StudentPermPhoneNbr);
                                            IF SalesForceRec3.FindFirst() Then begin
                                                UpdateFAFSAIDbySalesforce(SalesForceRec."18 Digit ID", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                                            end else begin
                                                StudentMasterRec.Reset();
                                                StudentMasterRec.SetFilter("Student Name", '@' + CONVERTSTR(AccountName, '@', '?'));
                                                StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                                StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                                if StudentMasterRec.FindSet() then begin
                                                    repeat
                                                        if Count1 <> 1 then
                                                            UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                                    until StudentMasterRec.Next() = 0;
                                                end else begin
                                                    StudentMasterRec.Reset();
                                                    StudentMasterRec.SetFilter("E-Mail Address", '@' + CONVERTSTR(ISIRRec.StudentPersonalEmail, '@', '?'));
                                                    StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                                    StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                                    if StudentMasterRec.FindSet() then begin
                                                        repeat
                                                            if Count1 <> 1 then
                                                                UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                                        until StudentMasterRec.Next() = 0;
                                                    end else begin
                                                        StudentMasterRec.Reset();
                                                        StudentMasterRec.SetRange("Date of Birth", ISIRRec.StudentDateOfBirth);
                                                        StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                                        StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                                        if StudentMasterRec.FindSet() then begin
                                                            repeat
                                                                if Count1 <> 1 then
                                                                    UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                                            until StudentMasterRec.Next() = 0;
                                                        end else begin
                                                            StudentMasterRec.Reset();
                                                            StudentMasterRec.SetRange("Phone Number", ISIRRec.StudentPermPhoneNbr);
                                                            StudentMasterRec.SetFilter("Type of FA Roster", '<>%1', StudentMasterRec."Type of FA Roster"::SFP);
                                                            StudentMasterRec.SetFilter("Global Dimension 1 Code", '%1', '9000');
                                                            if StudentMasterRec.FindSet() then begin
                                                                repeat
                                                                    if Count1 <> 1 then
                                                                        UpdateFAFSAIDbyStudent(StudentMasterRec."No.", ISIRRec, Count1);
                                                                until StudentMasterRec.Next() = 0;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                        End Else Begin
                                            UpdateFAFSAIDbySalesforce(SalesForceRec."18 Digit ID", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                                        end;
                                    End Else Begin
                                        UpdateFAFSAIDbySalesforce(SalesForceRec."18 Digit ID", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                                    end;
                                End Else Begin
                                    UpdateFAFSAIDbySalesforce(SalesForceRec."18 Digit ID", ISIRRec."Social Security No.", ISIRRec."FAFSA Type", ISIRRec);
                                end;
                            Until ISIRRec.Next() = 0;
                        CurrPage.Update();
                        message(Text002Lbl);

                    end else
                        exit;
                end;
            }
        }
    }

    procedure UpdateFAFSAIDbySalesforce(DigitID18: Code[18]; SSNNo: Code[9]; FAFSAType: Text[36]; ISIRRec: Record "ISIR File")
    Var
        StudentStatusRec: Record "Student Status";
        SemesterRec: Record "Semester Master-CS";
        SLcMToSalesforceCod: Codeunit SLcMToSalesforce;
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.SetFilter("18 Digit ID", '@' + CONVERTSTR(DigitID18, '@', '?'));
        if StudentMasterRec.FindFirst() then begin
            SemesterRec.Reset();
            SemesterRec.SetRange(Code, StudentMasterRec.Semester);
            IF SemesterRec.FindFirst() then
                if SemesterRec.Sequence = 1 then
                    if StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then
                        if not (StudentStatusRec.Status in [StudentStatusRec.Status::Graduated, StudentStatusRec.Status::"Pending Graduation",
                        StudentStatusRec.Status::ADWD, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                        StudentStatusRec.Status::Deceased]) then
                            if StudentStatusRec.Status <> StudentStatusRec.Status::" " then begin
                                Starting3D1 := COPYSTR(SSNNo, 1, 3);
                                Middle56D1 := COPYSTR(SSNNo, 4, 2);
                                Last4D1 := COPYSTR(SSNNo, 6, 4);
                                FinalValue := Starting3D1 + '-' + Middle56D1 + '-' + Last4D1;
                                StudentMasterRec.Validate("FSA ID", FinalValue);
                                StudentMasterRec."FAFSA Type" := ISIRRec."FAFSA Type";
                                StudentMasterRec."FAFSA Received" := true;
                                StudentMasterRec."FAFSA Applied" := true;
                                StudentMasterRec.Modify();

                                ISIRRec."Student No." := StudentMasterRec."No.";
                                ISIRRec."FAFSA ID" := FinalValue;
                                ISIRRec."Result Matched" := true;
                                ISIRRec."Updated In SLcM" := true;
                                ISIRRec.Modify();

                                SLcMToSalesforceCod.StudentMasterSFModify(StudentMasterRec);
                            end;

        end;
    end;

    procedure UpdateFAFSAIDbyStudent(No: Code[20]; ISIRRec: Record "ISIR File"; var Count1: Integer)
    Var
        StudentStatusRec: Record "Student Status";
        SemesterRec: Record "Semester Master-CS";
    begin
        StudentMasterRec.Reset();
        StudentMasterRec.Setrange("No.", No);
        if StudentMasterRec.FindFirst() then begin
            SemesterRec.Reset();
            SemesterRec.SetRange(Code, StudentMasterRec.Semester);
            IF SemesterRec.FindFirst() then
                if SemesterRec.Sequence > 1 then
                    if StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then
                        if not (StudentStatusRec.Status in [StudentStatusRec.Status::Graduated, StudentStatusRec.Status::"Pending Graduation",
                        StudentStatusRec.Status::ADWD, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                        StudentStatusRec.Status::Deceased]) then
                            if StudentStatusRec.Status <> StudentStatusRec.Status::" " then begin
                                Starting3D1 := COPYSTR(ISIRRec."Social Security No.", 1, 3);
                                Middle56D1 := COPYSTR(ISIRRec."Social Security No.", 4, 2);
                                Last4D1 := COPYSTR(ISIRRec."Social Security No.", 6, 4);
                                FinalValue := Starting3D1 + '-' + Middle56D1 + '-' + Last4D1;
                                StudentMasterRec.Validate("FSA ID", FinalValue);
                                StudentMasterRec."FAFSA Type" := ISIRRec."FAFSA Type";
                                StudentMasterRec."FAFSA Received" := true;
                                StudentMasterRec."FAFSA Applied" := true;
                                StudentMasterRec.Modify();

                                ISIRRec."Student No." := StudentMasterRec."No.";
                                ISIRRec."FAFSA ID" := FinalValue;
                                ISIRRec."Result Matched" := true;
                                ISIRRec."Updated In SLcM" := true;
                                ISIRRec.Modify();
                                Count1 := 1;
                            end;
        end;
    end;

    var

        ISIRRec: Record "ISIR File";
        ISIRRec1: Record "ISIR File";
        SalesForceRec: Record "SalesForce File";
        SalesForceRec1: Record "SalesForce File";
        SalesForceRec2: Record "SalesForce File";
        SalesForceRec3: Record "SalesForce File";
        StudentMasterRec: Record "Student Master-CS";
        AccountName: Text[100];
        Starting3D1: Text;
        Last4D1: Text;
        Middle56D1: Text;
        FinalValue: Text;
        BoolColor: Text;


    trigger OnAfterGetRecord()
    begin
        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';

    end;

    trigger OnOpenPage()
    begin
        IF Rec."Result Matched" = true then
            BoolColor := 'favorable'
        else
            BoolColor := 'Unfavorable';

        Currpage.Update();
    end;

}