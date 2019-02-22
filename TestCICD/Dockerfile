FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["./", "testwebapp/"]
RUN dotnet restore "testwebapp/testwebapp.csproj"
COPY . .
WORKDIR "/src/testwebapp"
RUN dotnet build "testwebapp.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "testwebapp.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "testwebapp.dll"]