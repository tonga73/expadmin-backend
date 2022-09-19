import { IsString, IsOptional, IsNotEmpty, IsInt } from 'class-validator';

export class CreateOfficeDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  secretary: string;

  @IsInt()
  @IsOptional()
  courtId: number;
}
