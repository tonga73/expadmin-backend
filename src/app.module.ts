import { Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

import { AppController } from './app.controller';
import { AppService } from './app.service';

import { UserModule } from './user/user.module';
import { RecordModule } from './record/record.module';
import { DistrictModule } from './district/district.module';
import { TracingModule } from './tracing/tracing.module';

@Module({
  imports: [UserModule, DistrictModule, RecordModule, TracingModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
