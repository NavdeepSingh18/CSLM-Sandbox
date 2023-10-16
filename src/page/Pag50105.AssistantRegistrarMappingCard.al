page 50105 "Assistant Registrar Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Test1-CS";
    Caption = 'Assistant Registrar Mappin';

    layout
    {
        area(Content)
        {
            group(General)
            {
                label("Alpha Range")
                {
                    ApplicationArea = All;
                    Caption = '"Alpha Range will Work on First Letter of Student''s Last Name."';
                    Style = Unfavorable;
                }
                field("Entry No."; Rec."Entry no")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                // field(Role; Rec.Role)
                // {
                //     ApplicationArea = All;
                //     Style = Strong;
                // }
                field("Start Alpha Range"; Rec."Start Alpha Range")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Alpha Range"; Rec."End Alpha Range")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update on Students")
            {
                Caption = 'Update on Students';
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapSetup;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF not Confirm('Do you want to update %1 on Students?', true, 'Assistant Registrar') then
                        exit;

                    IF Rec.Status = Rec.Status::Inactive then
                        Error('Status must be Active.');

                    if (Rec."Start Alpha Range" <> '') and (Rec."End Alpha Range" <> '') then
                        UpdateOnStudents(false);
                end;
            }

            action("Overwrite on Students")
            {
                Caption = 'Overwrite on Students';
                ShortcutKey = 'Ctrl+W';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = OverdueEntries;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF not Confirm('Do you want to Overwrite %1 on Students?', true, 'Assistant Registrar') then
                        exit;

                    IF Rec.Status = Rec.Status::Inactive then
                        Error('Status must be Active.');

                    if (Rec."Start Alpha Range" <> '') and (Rec."End Alpha Range" <> '') then
                        UpdateOnStudentsOverwrite(false);
                end;
            }
            action("View Mapped Students")
            {
                ApplicationArea = All;
                Caption = 'View Mapped Students';
                ShortcutKey = 'Ctrl+M';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = MapDimensions;

                trigger OnAction()
                begin
                    Rec.ViewStudentsWithUserList();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ClinicalCoordinatorPlanning: Record "Test1-CS";
    begin
        ClinicalCoordinatorPlanning.Reset();
        if ClinicalCoordinatorPlanning.FindLast() then;

        Rec."Entry No" := ClinicalCoordinatorPlanning."Entry no" + 1;
    end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // begin
    //     UpdateOnStudents(true);
    // end;

    procedure UpdateOnStudents(OnClosePage: Boolean)
    Var
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentValidity: Boolean;
        W: Dialog;
        Text001Lbl: Label 'Students     ############1################\';
        T: Integer;
        I: Integer;
    begin
        I := 0;

        IF Rec.Status = Rec.Status::Inactive then
            exit;

        if (Rec."Start Alpha Range" = '') OR (Rec."End Alpha Range" = '') then
            exit;

        W.Open('Updating Coordinators..\' + Text001Lbl);
        StudentMaster.Reset();
        StudentMaster.SetFilter("Last Name", '%1..%2', Rec."Start Alpha Range" + '*', Rec."End Alpha Range" + '*');
        StudentMaster.SetFilter("Assistant Registrar", '%1', '');
        if StudentMaster.FindSet() then begin
            T := StudentMaster.Count;
            repeat
                W.Update(1, Format(I) + ' of ' + Format(T));

                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                StudentValidity := true;
                if (StudentStatus.Status in
                [StudentStatus.Status::Graduated]) then
                    StudentValidity := false;

                if StudentValidity = true then begin
                    StudentMaster."Assistant Registrar" := Rec."User ID";
                    StudentMaster.Modify(true);
                    I += 1;
                end;
            until StudentMaster.Next() = 0;
        end;

        if OnClosePage = false then
            Message('%1 Mapping updated on %2 Student(s) Successfully.', 'Assistant Registrar', I);
    end;

    var
        SemesterFilter: Code[2048];

    procedure UpdateOnStudentsOverwrite(OnClosePage: Boolean)
    Var
        StudentMaster: Record "Student Master-CS";
        StudentStatus: Record "Student Status";
        StudentValidity: Boolean;
        W: Dialog;
        Text001Lbl: Label 'Students     ############1################\';
        T: Integer;
        I: Integer;
    begin
        I := 0;

        IF Rec.Status = Rec.Status::Inactive then
            exit;

        if (Rec."Start Alpha Range" = '') OR (Rec."End Alpha Range" = '') then
            exit;

        // GetClerkshipSemesterFilter();

        W.Open('Updating Coordinators..\' + Text001Lbl);
        StudentMaster.Reset();
        StudentMaster.SetFilter("Last Name", '%1..%2', Rec."Start Alpha Range" + '*', Rec."End Alpha Range" + '*');
        StudentMaster.SetFilter("Assistant Registrar", '<>%1', '');
        if StudentMaster.FindSet() then begin
            T := StudentMaster.Count;
            repeat
                W.Update(1, Format(I) + ' of ' + Format(T));

                StudentStatus.Reset();
                if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                StudentValidity := true;
                if (StudentStatus.Status in
                [StudentStatus.Status::Graduated]) then
                    StudentValidity := false;

                if StudentValidity = true then begin
                    StudentMaster."Assistant Registrar" := Rec."User ID";
                    StudentMaster.Modify();
                    I += 1;
                end;
            until StudentMaster.Next() = 0;
        end;

        if OnClosePage = false then
            Message('%1 mapping Updated on %2 Student(s) successfully.', 'Assistant Registrar', I);
    end;
}