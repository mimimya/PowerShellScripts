# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# .\파일이름변경.ps1

# 사용자로부터 파일명 입력 받기
$sourceName = Read-Host "변경할 대상 파일 이름 (예: 리드미.md)"
$targetName = Read-Host "새 이름 (예: README.md)"

# 현재 디렉토리 및 하위 폴더에서 지정한 이름의 파일 검색
Get-ChildItem -Path . -Recurse -File -Filter $sourceName | ForEach-Object {
    $originalPath = $_.FullName
    $newPath = Join-Path -Path $_.DirectoryName -ChildPath $targetName

    # 대상 파일이 이미 존재하는 경우
    if (Test-Path $newPath) {
        Write-Host "⚠️ 이미 존재: $newPath - 이름 변경 건너뜀" -ForegroundColor Yellow
    }
    else {
        try {
            Rename-Item -Path $originalPath -NewName $targetName
            Write-Host "✅ 변경 완료: $originalPath → $newPath" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ 오류 발생: $originalPath" -ForegroundColor Red
            Write-Host $_.Exception.Message
        }
    }
}
