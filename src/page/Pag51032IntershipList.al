page 51032 IntershipCSList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Intership-CS";
    Caption = 'Broadcast Email Template List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Department Type"; Rec."Department Type")
                {
                    ApplicationArea = All;

                }
                field(WorkDescription; WorkDescription)
                {
                    Caption = 'Email Template';
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    MultiLine = true;
                    // ShowCaption = false;
                    ToolTip = 'Specifies the Broadcast Email Template';

                    trigger OnValidate()
                    begin
                        Rec.SetWorkDescription(WorkDescription);
                        WorkDescription := Rec.GetWorkDescription();
                    end;
                }
            }
        }
    }
    actions
    {
        Area(Processing)
        {
            action("Upload Template")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ExpandAll;
                trigger OnAction()
                var
                    String: text;
                    FromFile: Text;
                    IStream: InStream;
                begin
                    IF File.UploadIntoStream('Select a Text File Only', '', 'All Files (*.*)|*.*', FromFile, IStream) then begin
                        IStream.Read(String);
                        String := ReplaceString(String, 'ËÇÖ', StrSubstNo('%1', ''''));
                        String := ReplaceString(String, 'ËÇô', StrSubstNo('%1', '-'));
                        String := ReplaceString(String, 'ËÇ¥', StrSubstNo('%1', '"'));
                        String := ReplaceString(String, 'ËÇ£', StrSubstNo('%1', '"'));
                        Rec.SetWorkDescription(String);
                        Message('Done');
                    end;
                end;
            }
            action("View Expanded Templates")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ExpandAll;
                trigger OnAction()
                var
                begin
                    Message('%1', WorkDescription);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(WorkDescription);
        IF Rec.Code <> '' then
            WorkDescription := Rec.GetWorkDescription();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    // var
    // myInt: Integer;
    begin
        IF Rec.GetFilter("Department Type") = 'EED Pre- Clinical' then
            Rec."Department Type" := Rec."Department Type"::"EED Pre-Clinical";

        IF Rec.GetFilter("Department Type") = 'EED Clinical' then
            Rec."Department Type" := Rec."Department Type"::"EED Clinical";

    end;

    trigger OnOpenPage()
    var
        AdvisingRequest: Record "Advising Request";
        IntOption: Integer;
    begin
        Rec.FilterGroup(2);
        IntOption := AdvisingRequest.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    Rec.SetFilter("Department Type", '%1|%2', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    Rec.Setfilter("Department Type", '%1|%2|%3', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical", Rec."Department Type"::" ");
                end;
        end;
        Rec.FilterGroup(0);
    end;

    var
        // myInt: Integer;
        WorkDescription: Text;
        Pagevar: Page Users;

    procedure ReplaceString(String: Text; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
        exit(NewString);
    end;
}