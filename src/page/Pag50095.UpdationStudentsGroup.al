page 50095 "Update Students Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    Caption = 'Update Students Group';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Group Input")
            {
                field(GroupCode; GroupCode)
                {
                    ApplicationArea = All;
                    Caption = 'Group Code';
                    ShowMandatory = true;
                    Style = Unfavorable;
                    TableRelation = Group.Code where("Group Type" = filter(Clinical), Blocked = const(false));

                    trigger OnValidate()
                    var
                        LGroup: Record Group;
                    begin
                        GroupDescription := '';
                        LGroup.Reset();
                        if LGroup.Get(GroupCode) then
                            GroupDescription := LGroup.Description;
                    end;
                }
                field(GroupDescription; GroupDescription)
                {
                    ApplicationArea = All;
                    Caption = 'Group Description';
                    Style = Unfavorable;
                    Editable = false;
                    MultiLine = true;
                }
            }
            repeater("Students")
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Spcl Accommodation Appln"; Rec."Spcl Accommodation Appln")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Add in Group")
            {
                ApplicationArea = All;
                Caption = 'Add in Group';
                Image = AddToHome;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentGroup: Record "Student Group";
                    StudentGroupChk: Record "Student Group";
                    LGroup: Record Group;
                    I: Integer;
                begin
                    if GroupCode = '' then
                        Error('Group Code must not be Blank.');
                    I := 0;
                    if not Confirm('Do you want to add below Students in Group %1 (%2)', True, GroupCode, GroupDescription) then
                        Exit;

                    LGroup.Reset();
                    if LGroup.Get(GroupCode) then;

                    Rec.FindFirst();
                    repeat
                        I += 1;
                        StudentGroupChk.Reset();
                        StudentGroupChk.SetRange("Student No.", Rec."No.");
                        StudentGroupChk.SetRange("Groups Code", GroupCode);
                        if not StudentGroupChk.findfirst() then begin
                            StudentGroup.Init();
                            StudentGroup.Validate("Student No.", Rec."No.");
                            StudentGroup."Academic Year" := Rec."Academic Year";
                            StudentGroup.Semester := Rec.Semester;
                            StudentGroup.Term := Rec.Term;
                            StudentGroup.Validate("Groups Code", GroupCode);
                            StudentGroup.Description := LGroup.Description;
                            StudentGroup."Created By" := UserId();
                            StudentGroup."Creation Date" := Today();
                            StudentGroup.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            StudentGroup."Group Type" := LGroup."Group Type";
                            StudentGroup.Insert(true);
                        end;
                    until Rec.Next() = 0;

                    Message('%1 Students added in Group - %2 (%3).', I, GroupCode, GroupDescription);
                end;
            }
            action("View/Update Notes")
            {
                ApplicationArea = All;
                Caption = 'View/Update Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("No.");
                    TemplateType := TemplateType::"Clinical Clerkship";
                    GroupType := GroupType::"Clinical Clerkship";
                    ClinicalBaseAppSubscribe.ViewEditNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                end;
            }
        }
    }

    var
        GroupCode: Code[20];
        GroupDescription: Text[50];
}