page 50649 "Copy Scholarship Document"
{
    Caption = 'Copy Scholarship Document';
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("No."; NoRange)
            {
                Caption = 'No.';
                ApplicationArea = All;
                TableRelation = "Scholarship Header-CS";
            }
            field("Admitted Year"; AdmittedYear)
            {
                Caption = 'Admitted Year';
                ApplicationArea = All;
                tableRelation = "Academic Year Master-CS";
            }
            field("RecNo 1"; RecNo1)
            {
                ApplicationArea = All;
                Caption = 'RecNo';
                Visible = false;
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Bulk Copy Scholarship")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                Visible = Bool1;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BulkCopyScholarship(NoRange, AdmittedYear);
                end;
            }
            action("Copy Scholarship")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                Visible = Bool;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CopyScholarship(NoRange, AdmittedYear, RecNo1)
                End;

            }
        }
    }

    var
        ScholarshipFeeHeaderCOLLEGE: Record "Scholarship Header-CS";
        ScholarshipFeeLineCOLLEGE: Record "Scholarship Line-CS";
        ScholarshipFeeHeader: Record "Scholarship Header-CS";
        ScholarshipFeeLine: Record "Scholarship Line-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoRange: Code[100];
        AdmittedYear: Code[20];
        RecNo1: Code[20];
        Bool: Boolean;
        Bool1: Boolean;


    procedure VariablePassing(RecNo: Code[20]);
    begin
        RecNo1 := RecNo;
    end;

    trigger OnOpenPage()
    begin
        If RecNo1 <> '' then begin
            Bool := True;
            Bool1 := false;
        End Else begin
            Bool := false;
            Bool1 := True;
        end;
    end;

    procedure BulkCopyScholarship(Range: Code[100]; AdmittedYear: Code[20])
    begin
        IF NOT CONFIRM('Do you want to Copy Document', FALSE) THEN
            EXIT;
        ScholarshipFeeHeaderCOLLEGE.RESET();
        ScholarshipFeeHeaderCOLLEGE.SETFILTER("No.", NoRange);
        IF ScholarshipFeeHeaderCOLLEGE.FINDFIRST() THEN
            REPEAT
                ScholarshipFeeHeader.INIT();
                ScholarshipFeeHeader.TRANSFERFIELDS(ScholarshipFeeHeaderCOLLEGE);
                ScholarshipFeeHeader."Admitted Year" := AdmittedYear;
                FeeSetupCS.Reset();
                FeeSetupCS.SetRange("Global Dimension 1 Code", ScholarshipFeeHeaderCOLLEGE."Global Dimension 1 Code");
                IF FeeSetupCS.FindFirst() then
                    ScholarshipFeeHeader."No." := NoSeriesManagement.GetNextNo(FeeSetupCS."Scholarship Detail No.", TODAY(), TRUE);
                ScholarshipFeeHeader.INSERT();

                ScholarshipFeeLineCOLLEGE.RESET();
                ScholarshipFeeLineCOLLEGE.SETRANGE("Document No.", ScholarshipFeeHeaderCOLLEGE."No.");
                IF ScholarshipFeeLineCOLLEGE.FINDFIRST() THEN
                    REPEAT
                        ScholarshipFeeLine.INIT();
                        ScholarshipFeeLine.TRANSFERFIELDS(ScholarshipFeeLineCOLLEGE);
                        ScholarshipFeeLine."Admitted Year" := AdmittedYear;
                        ScholarshipFeeLine."Document No." := ScholarshipFeeHeader."No.";
                        ScholarshipFeeLine.INSERT();
                    UNTIL ScholarshipFeeLineCOLLEGE.NEXT() = 0;
            UNTIL ScholarshipFeeHeaderCOLLEGE.NEXT() = 0;
        MESSAGE('Copy Document Successfully');
        Currpage.Close();
    end;

    procedure CopyScholarship(Range: Code[100]; AdmittedYear: Code[20]; RecNo: Code[20])
    Var
    begin
        IF NOT CONFIRM('Do you want to Copy Document', FALSE) THEN
            EXIT;
        ScholarshipFeeHeaderCOLLEGE.RESET();
        ScholarshipFeeHeaderCOLLEGE.SETFILTER("No.", NoRange);
        IF ScholarshipFeeHeaderCOLLEGE.FINDFIRST() THEN
            REPEAT
                ScholarshipFeeHeader.INIT();
                ScholarshipFeeHeader.TRANSFERFIELDS(ScholarshipFeeHeaderCOLLEGE, false);
                ScholarshipFeeHeader."Admitted Year" := AdmittedYear;
                ScholarshipFeeHeader."No." := RecNo;
                ScholarshipFeeHeader.Modify(true);

                ScholarshipFeeLineCOLLEGE.RESET();
                ScholarshipFeeLineCOLLEGE.SETRANGE("Document No.", ScholarshipFeeHeaderCOLLEGE."No.");
                IF ScholarshipFeeLineCOLLEGE.FINDFIRST() THEN
                    REPEAT
                        ScholarshipFeeLine.INIT();
                        ScholarshipFeeLine.TRANSFERFIELDS(ScholarshipFeeLineCOLLEGE);
                        ScholarshipFeeLine."Admitted Year" := AdmittedYear;
                        ScholarshipFeeLine."Document No." := ScholarshipFeeHeader."No.";
                        ScholarshipFeeLine.INSERT();
                    UNTIL ScholarshipFeeLineCOLLEGE.NEXT() = 0;
            UNTIL ScholarshipFeeHeaderCOLLEGE.NEXT() = 0;
        MESSAGE('Copy Document Successfully');
        Currpage.Close();
    end;
}


