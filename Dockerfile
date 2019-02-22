FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["./", "TestCICD/"]
COPY . .
WORKDIR "/src/TestCICD"
RUN dotnet restore "TestCICD.csproj"
RUN dotnet build "TestCICD.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "TestCICD.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TestCICD.dll"]
