page 50410 "Role Activities Adm-CS"
{
    PageType = CardPart;
    SourceTable = "Admission RoleCentre Cue-CS";

    layout
    {
        area(content)
        {
            cuegroup(Payments)
            {
                Caption = 'Payments';
                field("Overdue Student  Payment"; Rec."Overdue Student  Payment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Overdue Student  Payment';
                    Caption = 'Overdue Student  Payment';
                    DrillDownPageID = "Customer Ledger Entries";
                }
            }
            cuegroup("Student Status")
            {
                Caption = 'Student Status';
                field("Active Student"; Rec."Active Student")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData 50032 = R;
                    ToolTip = 'Active Student';
                    DrillDownPageID = "Student Details-CS";
                    Editable = false;
                }
                field("Inactive Student"; Rec."Inactive Student")
                {
                    ApplicationArea = All;
                    ToolTip = 'Inactive Student';
                    DrillDownPageID = "Student Details-CS";
                }
                field("Provisional Student"; Rec."Provisional Student")
                {
                    ApplicationArea = All;
                    ToolTip = 'Provisional Student';
                    DrillDownPageID = "Student Details-CS";
                }
            }
            cuegroup(Grp)
            {
                field("Expired Student"; Rec."Expired Student")
                {
                    ApplicationArea = All;
                    ToolTip = 'Expired Student';
                    DrillDownPageID = "Student Details-CS";
                }
                field("Withdrwal -In- Process"; Rec."Withdrwal -In- Process")
                {
                    ToolTip = 'Withdrwal -In- Process';
                    ApplicationArea = All;
                    DrillDownPageID = "Student Details-CS";
                }
                field("Withdrwal/Discontinue"; Rec."Withdrwal/Discontinue")
                {
                    ToolTip = 'Withdrwal/Discontinue';
                    ApplicationArea = All;
                    DrillDownPageID = "Student Details-CS";
                }
                field("Student Transfer-In-Process"; Rec."Student Transfer-In-Process")
                {
                    ToolTip = 'Student Transfer-In-Process';
                    ApplicationArea = All;
                    DrillDownPageID = "Student Details-CS";
                }
            }
            cuegroup("Student Category")
            {
                Caption = 'Student Category';
                field("Category General"; Rec."Category General")
                {
                    ToolTip = 'Provisional Student';
                    ApplicationArea = All;
                }
                field("Category Foreign"; Rec."Category Foreign")
                {
                    ToolTip = 'Category Foreign';
                    ApplicationArea = All;
                }
                field("Category NRI Special"; Rec."Category NRI Special")
                {
                    ToolTip = 'Category NRI Special';
                    ApplicationArea = All;
                }
                //Code Comment The Web client does not support displaying both Actions and Fields in the Cue Group 'Payments'. Only Fields will be displayed.
                /*   actions
                   {
                       action("Create Reminders...")
                       {
                           ApplicationArea = all;
                           ToolTip = 'Create Reminders...';
                           Caption = 'Create Reminders...';
                           Image = TileCamera;
                           RunObject = Report 188;
                       }
                       action("Create Finance Charge Memos...")
                       {
                           ApplicationArea = All;
                           ToolTip = 'Create Finance Charge Memos...';
                           Caption = 'Create Finance Charge Memos...';
                           Image = TileCamera;
                           RunObject = Report 191;
                       }
                   }*/
            }
        }
    }


    trigger OnOpenPage()
    begin
        /*
        Reset();
        IF NOT GET THEN BEGIN
         .INIT();
         .INSERT();
        END;
        
        SETFILTER("Due Date Filter",'<=%1',WORKDATE());
        SETFILTER("Overdue Date Filter",'<%1',WORKDATE());
        */
        //CALCFIELDS("Active Student");
        //MESSAGE('%1',"Active Student");

    end;
}

