page 50264 "Time Tbl SubPage-CS"
{
    // version V.001-CS
    Caption = 'Time Tbl SubPage-CS';
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Class Time Table Line-CS";
    SourceTableView = sorting("Document No.", "Line No.") order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Time Slot"; Rec."Time Slot")
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                Field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field(Interval; Rec.Interval)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Interval Type"; Rec."Interval Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("OverRide Validation"; Rec."OverRide Validation")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }


                field("Subject Group"; Rec."Subject Group")
                {
                    ApplicationArea = All;
                }
                field("Subject Class"; Rec."Subject Class")
                {
                    Caption = 'Subject Class';
                    ApplicationArea = All;
                    trigger OnValidate()
                    Begin

                        LabEnabled := true;
                        If Rec."Subject Class" = 'LAB' then
                            LabEnabled := false;
                    End;
                }

                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                }
                Field("Topic Code"; Rec."Topic Code")
                {
                    ApplicationArea = All;
                    Visible = LabEnabled;
                }
                Field("Topic Description"; Rec."Topic Description")
                {
                    ApplicationArea = All;
                    Visible = LabEnabled;
                }
                Field("Subject Category"; Rec."Subject Category")
                {
                    ApplicationArea = All;
                    Caption = 'Faculty Category';
                }

                field(Batch; Rec.Batch)
                {
                    ApplicationArea = All;
                }
                field("Different Faculty"; Rec."Different Faculty")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Different Room"; Rec."Different Room")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Room No"; Rec."Room No")
                {
                    ApplicationArea = All;
                }
                // field("Faculty 1 Start Date"; Rec."Faculty 1 Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Faculty 1 End Date"; Rec."Faculty 1 End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Faculty 1 Code"; Rec."Faculty 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 1 Name"; Rec."Faculty 1 Name")
                {
                    ApplicationArea = All;
                }
                // field("Faculty 2 Start Date"; Rec."Faculty 2 Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Faculty 2 End Date"; Rec."Faculty 2 End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Faculty 2 Code"; Rec."Faculty 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 2 Name"; Rec."Faculty 2 Name")
                {
                    ApplicationArea = All;
                }
                // field("Faculty 3 Start Date"; Rec."Faculty 3 Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Faculty 3 End Date"; Rec."Faculty 3 End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Faculty 3 Code"; Rec."Faculty 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 3 Name"; Rec."Faculty 3 Name")
                {
                    ApplicationArea = All;
                }
                // field("Faculty 4 Start Date"; Rec."Faculty 4 Start Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Faculty 4 End Date"; Rec."Faculty 4 End Date")
                // {
                //     ApplicationArea = All;
                // }
                field("Faculty 4 Code"; Rec."Faculty 4 Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty 4 Name"; Rec."Faculty 4 Name")
                {
                    ApplicationArea = All;
                }
                field("Extra Class"; Rec."Extra Class")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                Field("Final Time Table No."; Rec."Final Time Table No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Topics)
            {
                Image = Create;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                Enabled = LabEnabled;
                Visible = False;
                trigger OnAction()
                Var
                    SubjectTopicList: Page "Subject Topics List";
                begin
                    SubjectTopicList.VariablePassing(Rec."Document No.", Rec."Line No.");
                    SubjectTopicList.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        LabEnabled := true;
        If Rec."Subject Class" = 'LAB' then
            LabEnabled := false;
    end;

    trigger OnAfterGetRecord()
    begin
        LabEnabled := true;
        If Rec."Subject Class" = 'LAB' then
            LabEnabled := false;
    end;


    var
        LabEnabled: Boolean;

}