page 50578 "Test Buffer List"
{

    PageType = API;
    SourceTable = "Test Buffer";
    Caption = 'Test Buffer List';
    ApplicationArea = All;
    UsageCategory = Administration;
    EntityName = 'tB';
    EntitySetName = 'tB';
    DelayedInsert = true;
    APIPublisher = 'tB01';
    APIGroup = 'tB';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(studentnO; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(slcMId; Rec."SLcM ID")
                {
                    ApplicationArea = All;
                }

                field("digitStudentID"; Rec."18 Digit Student ID")
                {
                    ApplicationArea = All;
                }
                field("digitTestID"; Rec."18 Digit Test ID")
                {
                    ApplicationArea = All;
                }
                field("mCATBiologicalScience"; Rec."MCAT Biological Science")
                {
                    ApplicationArea = All;
                }
                field("mCATPhysicalScience"; Rec."MCAT Physical Science")
                {
                    ApplicationArea = All;
                }
                field("mCATTestScore"; Rec."MCAT Test Score")
                {
                    ApplicationArea = All;
                }
                field("mCATTotalScore"; Rec."MCAT Total Score")
                {
                    ApplicationArea = All;
                }
                field("mCATVerbalReasoning"; Rec."MCAT Verbal Reasoning")
                {
                    ApplicationArea = All;
                }
                field("mCATWriting"; Rec."MCAT Writing 1")
                {
                    ApplicationArea = All;
                }
                field("nBMECompTestScore"; Rec."NBME Comp Test Score")
                {
                    ApplicationArea = All;
                }
                field("newMCAT2015TestScore"; Rec."New MCAT 2015 Test Score")
                {
                    ApplicationArea = All;
                }
                field("overallScore"; Rec."Overall Score")
                {
                    ApplicationArea = All;
                }
                field("testDate"; Rec."Test Date")
                {
                    ApplicationArea = All;
                }
                field("uSMLEStep1Score"; Rec."USMLE Step 1 Score")
                {
                    ApplicationArea = All;
                }
                field("uSMLEStep2CKScore"; Rec."USMLE Step 2 CK Score")
                {
                    ApplicationArea = All;
                }
                field("uSMLEStep2CSScore"; Rec."USMLE Step 2 CS Score")
                {
                    ApplicationArea = All;
                }
                field("uSMLETestScore"; Rec."USMLE Test Score")
                {
                    ApplicationArea = All;
                }
                Field(mCATPsychological; Rec."MCAT Psychological")
                {
                    ApplicationArea = All;
                }
                field(teSt; Rec.Test)
                {
                    ApplicationArea = All;
                }
                field(instituteCode; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        RecQualifying: Record "Qualifying Detail Stud-CS";
        RecEducationSetup: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        TestBuffer: Record "Test Buffer";
    begin
        Rec.TestField(Rec."Student No.");
        Rec."Entry From Salesforce" := true;
        RecQualifying.Reset();
        if Rec."SLcM ID" = '' then begin
            RecQualifying.Init();
            RecQualifying.Validate("Student No.", Rec."Student No.");
        end
        else begin
            RecQualifying.SetRange("Student No.", Rec."Student No.");
            RecQualifying.SetRange("SLcM ID", Rec."SLcM ID");
            if RecQualifying.FindFirst() then;
        end;

        TestBuffer.Reset();
        TestBuffer.SetRange("Student No.", Rec."Student No.");
        if Rec."SLcM ID" <> '' then
            TestBuffer.SetRange("SLcM ID", Rec."SLcM ID");
        if TestBuffer.FindLast() then
            Rec."Line No." := TestBuffer."Line No." + 10000
        else
            Rec."Line No." := 10000;

        RecQualifying.Validate("Entry From Salesforce", true);
        RecQualifying.Validate("MCAT Test Score", Rec."MCAT Test Score");
        RecQualifying.Validate("NBME Comp Test Score", Rec."NBME Comp Test Score");
        RecQualifying.Validate("New MCAT 2015 Test Score", Rec."New MCAT 2015 Test Score");
        RecQualifying.Validate("Overall Score", Rec."Overall Score");
        RecQualifying.Validate("MCAT Biological Science", Rec."MCAT Biological Science");
        RecQualifying.Validate("MCAT Physical Science", Rec."MCAT Physical Science");
        RecQualifying.Validate("MCAT Total Score", Rec."MCAT Total Score");
        RecQualifying.Validate("MCAT Verbal Reasoning", Rec."MCAT Verbal Reasoning");
        RecQualifying.Validate("MCAT Writing 1", Rec."MCAT Writing 1");
        RecQualifying.Validate("Test Date", Rec."Test Date");

        RecQualifying.Validate(Test, Rec.Test);
        RecQualifying.Validate("USMLE Step 1 Score", Rec."USMLE Step 1 Score");
        RecQualifying.Validate("USMLE Step 2 CK Score", Rec."USMLE Step 2 CK Score");
        RecQualifying.Validate("USMLE Step 2 CS Score", Rec."USMLE Step 2 CS Score");

        RecQualifying.Validate("USMLE Test Score", Rec."USMLE Test Score");
        RecQualifying.Validate("MCAT Psychological", Rec."MCAT Psychological");

        RecQualifying.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecQualifying.Validate("Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        if Rec."SLcM ID" = '' then begin
            //TestField("Global Dimension 1 Code");
            RecEducationSetup.Reset();
            //RecEducationSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
            RecEducationSetup.FindFirst();
            RecEducationSetup.Testfield("SLcM Test ID Nos.");
            RecQualifying.Validate("SLcM ID", NoSeriesMgt.GetNextNo(RecEducationSetup."SLcM Test ID Nos.", 0D, TRUE));
            RecQualifying.Insert(true);
            Rec."SLcM ID" := RecQualifying."SLcM ID";
            RecQualifying.Validate("18 Digit Test ID", Rec."18 Digit Test ID");
        end;
        RecQualifying.Modify();
    end;
}
