page 50915 "Filter Student Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Temp Record";
    SourceTableView = sorting("Entry No")
    where(Field2 = filter(<> ''));
    Caption = 'Group';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    Caption = 'Select';
                    ApplicationArea = All;
                }
                field("Code"; Rec.Field2)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field("Description"; Rec.Field11)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure GetFilterfromGroup(var GroupCode1: Code[2048])

    var
        TempTable: Record "Temp Record";
        TempTable1: Record "Temp Record";
        GroupCode: Record Group;
        EntryNo: Integer;
        TemTable2: Record "Temp Record";
        TempRec: Record "Temp Record";
        Count1: Integer;

    begin
        Clear(EntryNo);
        GroupCode.Reset();
        if GroupCode.FindSet() then begin
            repeat
                TempTable.Reset();
                if TempTable.FindLast() then
                    EntryNo := TempTable."Entry No" + 1
                else
                    EntryNo := 1;
                TempTable1.Reset();
                TempTable1.SetRange(Field2, GroupCode.Code);
                if not TempTable1.FindFirst() then begin
                    TempTable1.Init();
                    TempTable1."Entry No" := EntryNo;
                    TempTable1.Field2 := GroupCode.Code;
                    TempTable1.Field11 := GroupCode.Description;
                    TempTable1."Unique ID" := UserId();
                    TempTable1.Insert();
                end;
            until GroupCode.Next() = 0;
        end;

        Commit();
        TemTable2.Reset();
        if TemTable2.FindFirst() then begin
            IF Page.RUNMODAL(Page::"Filter Student Group", TemTable2) = ACTION::LookupOK THEN begin
                Clear(Count1);
                Clear(GroupCode1);
                TempRec.Reset();
                TempRec.SetRange(Select, true);
                if TempRec.FindSet() then begin
                    repeat
                        Count1 += 1;
                        if Count1 = 1 then
                            GroupCode1 := TempRec.Field2;

                        if Count1 > 1 then begin
                            GroupCode1 += '|' + TempRec.Field2;
                        end;

                    until TempRec.Next() = 0;

                end;
            end;
        end;



    end;
}