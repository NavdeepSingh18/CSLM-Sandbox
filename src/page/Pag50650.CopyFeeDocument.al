page 50650 "Copy Fee Document"
{
    Caption = 'Copy Fee Document';
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            field("No."; NoRange)
            {
                Caption = 'Fee Course No.';
                ApplicationArea = All;
                TableRelation = "Fee Course Head-CS"."No.";
            }
            field("Academic Year"; AcademicYear)
            {
                Caption = 'Academic Year';
                ApplicationArea = All;
                tableRelation = "Academic Year Master-CS";
            }

        }
    }

    actions
    {
        area(creation)
        {
            action("Bulk Copy Fee")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                Visible = Bool1;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BulkCopyFee(NoRange, AcademicYear)
                End;

            }
            action("Copy Fee")
            {
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                Visible = Bool;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CopyFee(NoRange, AcademicYear, RecNo1)
                End;

            }
        }
    }

    var

        NoRange: Code[100];
        AcademicYear: Code[20];
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

    procedure BulkCopyFee(Range: Code[100]; AcademicYear: Code[20])
    Var
        FeeSetupCS: Record "Fee Setup-CS";
        CourseFeeHeaderCOLLEGE: Record "Fee Course Head-CS";
        CourseFeeLineCOLLEGE: Record "Fee Course Line-CS";
        CourseFeeHeader: Record "Fee Course Head-CS";
        CourseFeeLine: Record "Fee Course Line-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        IF NOT CONFIRM('Do you want to Copy Document', FALSE) THEN
            EXIT;
        CourseFeeHeaderCOLLEGE.RESET();
        CourseFeeHeaderCOLLEGE.SETFILTER("No.", NoRange);
        IF CourseFeeHeaderCOLLEGE.FINDFIRST() THEN begin
            REPEAT
                CourseFeeHeader.INIT();
                CourseFeeHeader.TRANSFERFIELDS(CourseFeeHeaderCOLLEGE);
                CourseFeeHeader."Academic Year" := AcademicYear;
                FeeSetupCS.Reset();
                FeeSetupCS.SetRange("Global Dimension 1 Code", CourseFeeHeaderCOLLEGE."Global Dimension 1 Code");
                IF FeeSetupCS.FindFirst() then
                    CourseFeeHeader."No." := NoSeriesManagement.GetNextNo(FeeSetupCS."Course Fee No", TODAY(), TRUE);
                CourseFeeHeader.INSERT();

                CourseFeeLineCOLLEGE.RESET();
                CourseFeeLineCOLLEGE.SETRANGE("Document No.", CourseFeeHeaderCOLLEGE."No.");
                IF CourseFeeLineCOLLEGE.FINDFIRST() THEN
                    REPEAT
                        CourseFeeLine.INIT();
                        CourseFeeLine.TRANSFERFIELDS(CourseFeeLineCOLLEGE);
                        CourseFeeLine."Academic Year" := AcademicYear;
                        CourseFeeLine."Document No." := CourseFeeHeader."No.";
                        CourseFeeLine.Semester := CourseFeeHeader.Semester;
                        CourseFeeLine.INSERT();
                    UNTIL CourseFeeLineCOLLEGE.NEXT() = 0;
            UNTIL CourseFeeHeaderCOLLEGE.NEXT() = 0;
            MESSAGE('Copy Document Successfully');
        end;
    end;

    procedure CopyFee(Range: Code[100]; AcademicYear: Code[20]; RecNo: Code[20])
    Var
        CourseFeeHeaderCOLLEGE: Record "Fee Course Head-CS";
        CourseFeeLineCOLLEGE: Record "Fee Course Line-CS";
        CourseFeeHeader: Record "Fee Course Head-CS";
        CourseFeeLine: Record "Fee Course Line-CS";
    begin
        IF NOT CONFIRM('Do you want to Copy Document', FALSE) THEN
            EXIT;
        CourseFeeHeaderCOLLEGE.RESET();
        CourseFeeHeaderCOLLEGE.SETFILTER("No.", NoRange);
        IF CourseFeeHeaderCOLLEGE.FINDFIRST() THEN begin
            REPEAT
                CourseFeeHeader.INIT();
                CourseFeeHeader.TRANSFERFIELDS(CourseFeeHeaderCOLLEGE, false);
                CourseFeeHeader."Academic Year" := AcademicYear;
                CourseFeeHeader."No." := RecNo;
                CourseFeeHeader.Modify(true);

                CourseFeeLineCOLLEGE.RESET();
                CourseFeeLineCOLLEGE.SETRANGE("Document No.", CourseFeeHeaderCOLLEGE."No.");
                IF CourseFeeLineCOLLEGE.FINDFIRST() THEN
                    REPEAT
                        CourseFeeLine.INIT();
                        CourseFeeLine.TRANSFERFIELDS(CourseFeeLineCOLLEGE);
                        CourseFeeLine."Academic Year" := AcademicYear;
                        CourseFeeLine."Document No." := CourseFeeHeader."No.";
                        CourseFeeLine.Semester := CourseFeeHeader.Semester;
                        CourseFeeLine.INSERT();
                    UNTIL CourseFeeLineCOLLEGE.NEXT() = 0;
            UNTIL CourseFeeHeaderCOLLEGE.NEXT() = 0;
            MESSAGE('Copy Document Successfully');
        end;
    end;


}

